import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/ai/data/datasources/ai_remote_data_source.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  AiRepositoryImpl(this._remote, this._cache, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final AiRemoteDataSource _remote;
  final RequestCache _cache;
  final DateTime Function() _now;

  /// Until sign-out. Each answer cost the user money, and only they decide
  /// when a new one is worth paying for.
  static const _forever = Duration(days: 3650);

  static String _insightsKey(String fingerprint) => 'ai/insights/$fingerprint';

  @override
  Future<Result<Insight>> insights(AiCredentials credentials, {bool regenerate = false}) async =>
      _asRead(
        await guardApi(
          () => _cache.fetch(
            _insightsKey(AiKeyRules.fingerprint(credentials.apiKey)),
            ttl: _forever,
            force: regenerate,
            load: () async => Insight(
              markdown: await _remote.insights(credentials),
              model: credentials.model,
              writtenAt: _now(),
            ),
          ),
        ),
      );

  @override
  Insight? cachedInsights(String keyFingerprint) => _cache.peek(_insightsKey(keyFingerprint));

  @override
  Future<Result<String>> ask(String question, AiCredentials credentials) async =>
      _asRead(await guardApi(() => _remote.ask(question, credentials)));

  /// These POSTs only read. A dropped connection is a slow answer to ask
  /// again, not an unknown write to reconcile.
  static Result<T> _asRead<T>(Result<T> result) => switch (result) {
    Err(failure: UnknownOutcomeFailure()) => const Err(TimeoutFailure()),
    _ => result,
  };
}
