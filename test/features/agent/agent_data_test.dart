import 'dart:convert';

import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/features/agent/data/datasources/agent_remote_data_source.dart';
import 'package:agentfolio/features/agent/data/repositories/agent_repository_impl.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';

/// Shaped exactly as `web/routers/agent.py` answers.
Map<String, Object?> threadJson(int id, String title, {String type = 'finance'}) => {
  'id': id,
  'agent_type': type,
  'title': title,
  'created_at': '2026-10-12T04:00:00',
  'updated_at': '2026-10-12T05:30:00.123456',
};

void main() {
  late FakeHttpAdapter adapter;
  late AgentRepositoryImpl repo;
  late RequestCache cache;
  late List<Map<String, Object?>> serverThreads;

  setUp(() {
    serverThreads = [threadJson(2, 'Risk check'), threadJson(1, '')];
    adapter = FakeHttpAdapter((o) async {
      final body = o.data is Map ? o.data as Map : const <String, Object?>{};
      return switch ((o.method, o.path)) {
        ('GET', '/api/agent/threads') => jsonBody({'premium': true, 'threads': serverThreads}),
        ('GET', '/api/agent/threads/2/messages') => jsonBody({
          'agent_type': 'trading',
          'messages': [
            {'role': 'user', 'text': '[System: Proposal ab12cd34 REJECTED.] REJECT ab12cd34'},
            {'role': 'assistant', 'text': 'Done. The proposal is rejected.'},
            {'role': 'tool', 'text': 'odd role'},
          ],
        }),
        ('GET', '/api/agent/threads/9/messages') => jsonBody({
          'error': 'Conversation not found',
        }, status: 404),
        ('POST', '/api/agent/threads') => jsonBody({
          'ok': true,
          'thread': threadJson(3, 'New conversation', type: body['agent_type'] as String),
        }),
        ('PATCH', '/api/agent/threads/2') => jsonBody({
          'ok': true,
          'thread': threadJson(2, body['title'] as String),
        }),
        ('DELETE', '/api/agent/threads/2') => jsonBody({'ok': true}),
        ('POST', '/api/agent/chat') => jsonBody({
          'reply': '  Your P&L is up.  ',
          if (body['thread_id'] != null) 'thread_id': body['thread_id'],
          if ((body['message'] as String).startsWith('APPROVE'))
            'approval_result': 'Proposal ab12cd34 APPROVED and executed. Order ID: 77',
        }),
        ('POST', '/api/agent/new-chat') => jsonBody({'ok': true}),
        _ => jsonBody({'error': 'unexpected ${o.method} ${o.path}'}, status: 500),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))..httpClientAdapter = adapter;
    cache = RequestCache();
    repo = AgentRepositoryImpl(AgentRemoteDataSource(ApiClient.withDio(dio)), cache);
  });

  Map<String, Object?> lastBody() =>
      jsonDecode(jsonEncode(adapter.requests.last.data)) as Map<String, Object?>;

  test('threads parse, with server times read as UTC and blank titles defaulted', () async {
    final list = (await repo.threads(AgentType.finance)).valueOrNull!;
    expect(list.premium, isTrue);
    expect(list.threads.map((t) => t.title), ['Risk check', 'New conversation']);
    expect(list.threads.first.updatedAt, DateTime.utc(2026, 10, 12, 5, 30, 0, 123, 456));
    expect(adapter.requests.single.queryParameters, {'agent_type': 'finance'});
  });

  test('a non-premium answer is an empty list, not an error', () async {
    adapter.handler = (o) async => jsonBody({'premium': false, 'threads': <Object>[]});
    final list = (await repo.threads(AgentType.trading)).valueOrNull!;
    expect(list.premium, isFalse);
    expect(list.threads, isEmpty);
  });

  test('history shows what the user typed, and unknown roles as the agent', () async {
    final messages = (await repo.messages(2)).valueOrNull!;
    expect(messages.map((m) => (m.role, m.text)), [
      (ChatRole.user, 'REJECT ab12cd34'),
      (ChatRole.assistant, 'Done. The proposal is rejected.'),
      (ChatRole.assistant, 'odd role'),
    ]);
    expect(messages.map((m) => m.id).toSet(), hasLength(3));
  });

  test("another user's thread is unavailable", () async {
    expect((await repo.messages(9)).failureOrNull, isA<UnavailableFailure>());
  });

  test('chat sends thread_id only for a saved thread, and reads the reply', () async {
    final unsaved = (await repo.send('hi', AgentType.finance)).valueOrNull!;
    expect(unsaved.reply, 'Your P&L is up.');
    expect(lastBody(), {'message': 'hi', 'agent_type': 'finance'});

    final saved = (await repo.send(
      'APPROVE ab12cd34',
      AgentType.trading,
      threadId: 2,
    )).valueOrNull!;
    expect(lastBody(), {'message': 'APPROVE ab12cd34', 'agent_type': 'trading', 'thread_id': 2});
    expect(saved.threadId, 2);
    expect(saved.approvalResult, contains('Order ID: 77'));
  });

  test('a chat whose answer never came is an unknown outcome, sent once', () async {
    adapter.handler = (o) async =>
        throw DioException(requestOptions: o, type: DioExceptionType.receiveTimeout);
    final result = await repo.send('hi', AgentType.finance, threadId: 2);
    expect(result.failureOrNull, isA<UnknownOutcomeFailure>());
    expect(adapter.requests, hasLength(1));
  });

  test('create, rename and delete update the cached list without a refetch', () async {
    await repo.threads(AgentType.finance);
    await repo.createThread(AgentType.finance);
    expect(repo.cachedThreads(AgentType.finance)!.threads.map((t) => t.id), [3, 2, 1]);

    await repo.rename(2, 'Renamed');
    expect(repo.cachedThreads(AgentType.finance)!.threads[1].title, 'Renamed');

    await repo.delete(2);
    expect(repo.cachedThreads(AgentType.finance)!.threads.map((t) => t.id), [3, 1]);
    expect(
      adapter.requests.where((r) => r.path == '/api/agent/threads' && r.method == 'GET'),
      hasLength(1),
    );
  });

  test('a saved-thread reply refetches the list; a trading reply drops trading data', () async {
    await repo.threads(AgentType.trading);
    cache.put('trading/proposals', 'stale');
    await repo.send('hi', AgentType.trading, threadId: 2);
    expect(cache.peek<String>('trading/proposals'), isNull);
    await repo.threads(AgentType.trading);
    expect(
      adapter.requests.where((r) => r.path == '/api/agent/threads' && r.method == 'GET'),
      hasLength(2),
    );
  });
}
