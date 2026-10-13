import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ai_insights_view_model.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ask_view_model.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_ai.dart';
import '../../helpers/fake_auth_repository.dart';
import '../../helpers/recording_sink.dart';

const _keyA = 'sk-or-v1-aaaaaaaaaaaaaaaa';
const _keyB = 'sk-or-v1-bbbbbbbbbbbbbbbb';

void main() {
  late Telemetry telemetry;
  late SessionProvider session;
  late FakeAuthRepository auth;
  late FakeAiKeyRepository keys;
  late AiKeyProvider aiKey;

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    (session, auth) = await signedInSession(telemetry);
    keys = FakeAiKeyRepository();
  });

  Future<AiKeyProvider> provider() async {
    aiKey = AiKeyProvider(repository: keys, session: session, telemetry: telemetry);
    await settle();
    return aiKey;
  }

  group('AiKeyProvider', () {
    test('looks up the saved key and model, holding only a fingerprint', () async {
      keys
        ..keys['A123'] = _keyA
        ..models['A123'] = 'openai/gpt-4o';
      final p = await provider();
      expect(p.isReady, isTrue);
      expect(p.hasKey, isTrue);
      expect(p.keyFingerprint, AiKeyRules.fingerprint(_keyA));
      expect(p.model, 'openai/gpt-4o');
      final credentials = await p.credentials();
      expect(credentials?.apiKey, _keyA);
      expect(credentials?.model, 'openai/gpt-4o');
    });

    test('no key: ready, with the default model and no credentials', () async {
      final p = await provider();
      expect(p.isReady, isTrue);
      expect(p.hasKey, isFalse);
      expect(p.model, AiModels.fallback);
      expect(await p.credentials(), isNull);
    });

    test('saving and removing a key update everyone listening', () async {
      final p = await provider();
      var changes = 0;
      p.addListener(() => changes++);
      await p.saveKey('  $_keyA\n');
      expect(keys.keys['A123'], _keyA);
      expect(p.keyFingerprint, AiKeyRules.fingerprint(_keyA));
      await p.removeKey();
      expect(p.hasKey, isFalse);
      expect(keys.keys, isEmpty);
      expect(changes, 2);
    });

    test('a model id that is not one is ignored', () async {
      final p = await provider();
      await p.setModel('gpt-4o');
      expect(p.model, AiModels.fallback);
      await p.setModel('anthropic/claude-3.5-haiku');
      expect(keys.models['A123'], 'anthropic/claude-3.5-haiku');
    });

    test('an unreadable Keychain means no key, not an error', () async {
      keys
        ..keys['A123'] = _keyA
        ..failReads = true;
      final p = await provider();
      expect(p.isReady, isTrue);
      expect(p.hasKey, isFalse);
      expect(await p.credentials(), isNull);
    });

    test('signing out on purpose removes the key from the device', () async {
      keys.keys['A123'] = _keyA;
      final p = await provider();
      await session.signOut();
      expect(keys.forgotten, ['A123']);
      expect(keys.keys, isEmpty);
      expect(p.hasKey, isFalse);
    });

    test('an expired session keeps the key; another user never sees it', () async {
      keys
        ..keys['A123'] = _keyA
        ..keys['B456'] = _keyB;
      final p = await provider();

      // The cookie expires: the server says signed out.
      auth.sessionResult = const Success(Session.signedOut());
      await session.refresh();
      expect(keys.forgotten, isEmpty);
      expect(keys.keys['A123'], _keyA);
      expect(p.hasKey, isFalse);

      // Someone else signs in on this phone.
      auth.sessionResult = Success(signedInAs('B456'));
      await session.refresh();
      await settle();
      expect((await p.credentials())?.apiKey, _keyB);
    });
  });

  group('insights', () {
    late FakeAiRepository ai;

    setUp(() => ai = FakeAiRepository());

    test('waits to be asked: each one is billed to the user', () async {
      keys.keys['A123'] = _keyA;
      final vm = AiInsightsViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      expect(vm.state, isA<ViewIdle<Insight>>());
      expect(ai.calls, isEmpty);

      await vm.generate();
      expect(vm.state.dataOrNull?.markdown, contains('Health'));
      expect(ai.calls, ['insights:openai/gpt-4o-mini']);

      // The next visit to Home shows it at once, without paying again.
      final again = AiInsightsViewModel(ai: ai, aiKey: aiKey, telemetry: telemetry);
      expect(again.state.dataOrNull?.markdown, contains('Health'));
      expect(ai.calls, hasLength(1));
    });

    test('regenerate keeps the old text on screen, and on failure', () async {
      keys.keys['A123'] = _keyA;
      final vm = AiInsightsViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      await vm.generate();

      ai
        ..insightsResult = const Err(TimeoutFailure())
        ..gate = Completer();
      final pending = vm.generate();
      await settle();
      expect(vm.state, isA<ViewData<Insight>>().having((s) => s.refreshing, 'refreshing', true));
      ai.gate!.complete();
      await pending;

      final state = vm.state as ViewData<Insight>;
      expect(state.data.markdown, contains('Health'));
      expect(state.refreshFailure, isA<TimeoutFailure>());
      expect(ai.calls.last, endsWith(':regenerate'));
    });

    test('a refused key is told apart from other failures', () async {
      keys.keys['A123'] = _keyA;
      ai.insightsResult = const Err(ValidationFailure('Invalid OpenRouter API key.'));
      final vm = AiInsightsViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      await vm.generate();
      expect(vm.state, isA<ViewError<Insight>>());
      expect(vm.failedOnKey, isTrue);
    });

    test('a new key starts over; an answer landing after the change is dropped', () async {
      keys.keys['A123'] = _keyA;
      final vm = AiInsightsViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      ai.gate = Completer();
      final pending = vm.generate();
      await settle();

      await aiKey.saveKey(_keyB);
      expect(vm.state, isA<ViewIdle<Insight>>());
      ai.gate!.complete();
      await pending;
      expect(vm.state, isA<ViewIdle<Insight>>());
    });
  });

  group('ask', () {
    late FakeAiRepository ai;

    setUp(() => ai = FakeAiRepository());

    test('one question at a time, answered in order', () async {
      keys.keys['A123'] = _keyA;
      final vm = AskViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      ai.gate = Completer();
      final first = vm.ask('  How diversified?  ');
      await settle();
      expect(vm.busy, isTrue);
      await vm.ask('Ignored while busy');
      ai.gate!.complete();
      await first;

      expect(vm.exchanges.map((e) => e.question), ['How diversified?']);
      expect(vm.exchanges.single.answer.dataOrNull, contains('IT is 83%'));
      expect(ai.calls, ['ask:How diversified?']);
    });

    test('a failed question can be asked again in place', () async {
      keys.keys['A123'] = _keyA;
      final vm = AskViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      ai.askResult = const Err(NetworkFailure());
      await vm.ask('Risk?');
      expect(vm.exchanges.single.answer, isA<ViewError<String>>());

      ai.askResult = const Success('Moderate.');
      await vm.retry(vm.exchanges.single.id);
      expect(vm.exchanges, hasLength(1));
      expect(vm.exchanges.single.answer.dataOrNull, 'Moderate.');
    });

    test('without a key, the question fails asking for one', () async {
      final vm = AskViewModel(ai: ai, aiKey: await provider(), telemetry: telemetry);
      await vm.ask('Risk?');
      final answer = vm.exchanges.single.answer as ViewError<String>;
      expect(AiKeyRules.isKeyFailure(answer.failure), isTrue);
      expect(ai.calls, isEmpty);
    });
  });
}
