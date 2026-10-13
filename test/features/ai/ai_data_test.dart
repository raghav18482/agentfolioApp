import 'dart:convert';

import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/storage/secure_store.dart';
import 'package:agentfolio/features/ai/data/datasources/ai_remote_data_source.dart';
import 'package:agentfolio/features/ai/data/repositories/ai_key_repository_impl.dart';
import 'package:agentfolio/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_ai.dart';
import '../../helpers/fake_http_adapter.dart';

class _MockSecureStore extends Mock implements SecureStore;

void main() {
  const keyA = AiCredentials(apiKey: 'sk-or-v1-aaaaaaaaaaaaaaaa', model: 'openai/gpt-4o-mini');
  const keyB = AiCredentials(apiKey: 'sk-or-v1-bbbbbbbbbbbbbbbb', model: 'openai/gpt-4o-mini');

  late FakeHttpAdapter adapter;
  late AiRepositoryImpl repo;
  late int insightCount;

  setUp(() {
    insightCount = 0;
    adapter = FakeHttpAdapter((o) async {
      final body = o.data as Map<String, Object?>;
      return switch (o.path) {
        '/api/ai/insights' when body['api_key'] == 'sk-or-v1-bad-key-000000' => jsonBody({
          'error': 'Invalid OpenRouter API key. Please check and try again.',
        }, status: 400),
        '/api/ai/insights' => jsonBody({'insight': 'Insight ${++insightCount}'}),
        '/api/ai/ask' => jsonBody({'answer': 'About "${body['question']}"'}),
        _ => jsonBody({'error': 'nope'}, status: 404),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))..httpClientAdapter = adapter;
    repo = AiRepositoryImpl(AiRemoteDataSource(ApiClient.withDio(dio)), RequestCache());
  });

  test('sends the key and model as the web app does, and reads the insight', () async {
    final result = await repo.insights(keyA);
    expect(result.valueOrNull?.markdown, 'Insight 1');
    expect(result.valueOrNull?.model, 'openai/gpt-4o-mini');
    final sent = adapter.requests.single;
    expect(sent.method, 'POST');
    expect(jsonDecode(jsonEncode(sent.data)), {
      'api_key': 'sk-or-v1-aaaaaaaaaaaaaaaa',
      'model': 'openai/gpt-4o-mini',
    });
  });

  test('an insight is kept per key: paid for once, until regenerated', () async {
    await repo.insights(keyA);
    expect((await repo.insights(keyA)).valueOrNull?.markdown, 'Insight 1');
    expect(adapter.requests, hasLength(1));
    expect(repo.cachedInsights(AiKeyRules.fingerprint(keyA.apiKey))?.markdown, 'Insight 1');

    // A different key never sees what the first one paid for.
    expect(repo.cachedInsights(AiKeyRules.fingerprint(keyB.apiKey)), isNull);
    expect((await repo.insights(keyB)).valueOrNull?.markdown, 'Insight 2');

    expect((await repo.insights(keyA, regenerate: true)).valueOrNull?.markdown, 'Insight 3');
  });

  test('a refused key is a validation failure the UI can recognise', () async {
    final result = await repo.insights(
      const AiCredentials(apiKey: 'sk-or-v1-bad-key-000000', model: 'openai/gpt-4o'),
    );
    final failure = result.failureOrNull!;
    expect(failure, isA<ValidationFailure>());
    expect(AiKeyRules.isKeyFailure(failure), isTrue);
  });

  test('ask sends the question with the credentials', () async {
    final result = await repo.ask('How diversified am I?', keyA);
    expect(result.valueOrNull, 'About "How diversified am I?"');
    expect((adapter.requests.single.data as Map)['question'], 'How diversified am I?');
  });

  test('a dropped connection is a timeout to retry, not an unknown write', () async {
    adapter.handler = (o) async =>
        throw DioException(requestOptions: o, type: DioExceptionType.receiveTimeout);
    expect((await repo.insights(keyA)).failureOrNull, isA<TimeoutFailure>());
    expect((await repo.ask('q', keyA)).failureOrNull, isA<TimeoutFailure>());
  });

  group('key storage', () {
    test('the key goes to secure storage, per user, never under the client code', () async {
      final secure = _MockSecureStore();
      final written = <String, String>{};
      when(() => secure.write(any(), any())).thenAnswer((i) async {
        written[i.positionalArguments[0] as String] = i.positionalArguments[1] as String;
      });
      when(() => secure.delete(any())).thenAnswer((i) async {
        written.remove(i.positionalArguments[0]);
      });
      final prefs = await memoryPrefs();
      final store = AiKeyRepositoryImpl(secure, prefs);

      await store.saveKey('A123', ' sk-or-v1-aaaaaaaaaaaaaaaa\n');
      await store.saveKey('B456', 'sk-or-v1-bbbbbbbbbbbbbbbb');
      await store.setModel('A123', 'openai/gpt-4o');

      expect(written.values, ['sk-or-v1-aaaaaaaaaaaaaaaa', 'sk-or-v1-bbbbbbbbbbbbbbbb']);
      expect(written.keys.any((k) => k.contains('A123')), isFalse);
      expect(store.model('A123'), 'openai/gpt-4o');
      expect(store.model('B456'), isNull);

      await prefs.setAgentDraft('${written.keys.first.split('.').last}.finance', 'half-typed');
      await store.forget('A123');
      expect(written.values, ['sk-or-v1-bbbbbbbbbbbbbbbb']);
      expect(store.model('A123'), isNull);
      expect(prefs.agentDraft('${written.keys.first.split('.').last}.finance'), isNull);
    });
  });
}
