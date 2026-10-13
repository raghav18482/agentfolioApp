import 'dart:async';

import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/session/session_epoch.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_key_repository.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_repository.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'fake_auth_repository.dart';

Session signedInAs(String clientId, {bool premium = false}) => Session.signedIn(
  user: AppUser(
    id: clientId,
    premium: PremiumStatus(registered: premium),
  ),
  accounts: [
    BrokerAccount(id: clientId, brokerId: BrokerRegistry.defaultBrokerId, clientCode: clientId),
  ],
  activeAccountId: clientId,
);

/// A session provider already signed in as [clientId].
Future<(SessionProvider, FakeAuthRepository)> signedInSession(
  Telemetry telemetry, {
  String clientId = 'A123',
  bool premium = false,
}) async {
  final auth = FakeAuthRepository()
    ..sessionResult = Success(signedInAs(clientId, premium: premium));
  final session = SessionProvider(
    repository: auth,
    cache: RequestCache(),
    epoch: SessionEpoch(),
    telemetry: telemetry,
    expirySignal: SessionExpirySignal(),
  );
  await session.refresh();
  return (session, auth);
}

/// Real [Prefs] over in-memory storage.
Future<Prefs> memoryPrefs() async {
  SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
  return Prefs(
    await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    ),
  );
}

class FakeAiKeyRepository implements AiKeyRepository {
  final keys = <String, String>{};
  final models = <String, String>{};
  final forgotten = <String>[];
  bool failReads = false;

  @override
  Future<String?> readKey(String userId) async {
    if (failReads) throw StateError('keychain locked');
    return keys[userId];
  }

  @override
  Future<void> saveKey(String userId, String key) async => keys[userId] = key.trim();

  @override
  Future<void> deleteKey(String userId) async => keys.remove(userId);

  @override
  String? model(String userId) => models[userId];

  @override
  Future<void> setModel(String userId, String model) async => models[userId] = model;

  @override
  Future<void> forget(String userId) async {
    forgotten.add(userId);
    keys.remove(userId);
    models.remove(userId);
  }
}

class FakeAiRepository implements AiRepository {
  final calls = <String>[];
  final cache = <String, Insight>{};
  Result<String> insightsResult = const Success('## Health\nUp **Rs. 3,600** overall.');
  Result<String> askResult = const Success('You hold **3** stocks; IT is 83% of it.');

  /// When set, answers wait for it: to look at the in-between states.
  Completer<void>? gate;

  @override
  Future<Result<Insight>> insights(AiCredentials credentials, {bool regenerate = false}) async {
    calls.add('insights:${credentials.model}${regenerate ? ':regenerate' : ''}');
    await gate?.future;
    final fingerprint = AiKeyRules.fingerprint(credentials.apiKey);
    final cached = cache[fingerprint];
    if (!regenerate && cached != null) return Success(cached);
    return switch (insightsResult) {
      Success(:final value) => Success(
        cache[fingerprint] = Insight(
          markdown: value,
          model: credentials.model,
          writtenAt: DateTime.now(),
        ),
      ),
      Err(:final failure) => Err(failure),
    };
  }

  @override
  Insight? cachedInsights(String keyFingerprint) => cache[keyFingerprint];

  @override
  Future<Result<String>> ask(String question, AiCredentials credentials) async {
    calls.add('ask:$question');
    await gate?.future;
    return askResult;
  }
}
