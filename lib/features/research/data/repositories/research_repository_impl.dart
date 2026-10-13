import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/research/data/datasources/research_remote_data_source.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/repositories/research_repository.dart';

/// Lifetimes match the web app's react-query `staleTime`s and the server's
/// own caches, so a revisit inside them costs nothing.
abstract final class _Ttl {
  static const technical = Duration(minutes: 5);
  static const prediction = Duration(minutes: 5);
  static const fundamental = Duration(minutes: 10);

  /// The server keeps a summary six hours; asking again sooner only returns
  /// the same text.
  static const summary = Duration(hours: 6);
  static const glossary = Duration(hours: 12);
}

abstract final class _Key {
  static String technical(String s) => 'research/technical/$s';
  static String fundamental(String s) => 'research/fundamental/$s';
  static String prediction(String s) => 'research/prediction/$s';
  static String summary(String s) => 'research/summary/$s';
  static const glossary = 'static/glossary';
}

class ResearchRepositoryImpl implements ResearchRepository {
  ResearchRepositoryImpl(this._remote, this._cache, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final ResearchRemoteDataSource _remote;
  final RequestCache _cache;
  final DateTime Function() _now;

  @override
  Future<Result<Technicals>> technicals(String symbol, {bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.technical(symbol),
      ttl: _Ttl.technical,
      force: force,
      load: () async => (await _remote.technical(symbol)).toEntity(),
    ),
  );

  @override
  Future<Result<Fundamentals>> fundamentals(String symbol, {bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.fundamental(symbol),
      ttl: _Ttl.fundamental,
      force: force,
      load: () async => (await _remote.fundamental(symbol)).toEntity(),
    ),
  );

  @override
  Future<Result<Prediction>> prediction(String symbol, {bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.prediction(symbol),
      ttl: _Ttl.prediction,
      force: force,
      load: () async => (await _remote.predict(symbol)).toEntity(),
    ),
  );

  @override
  Future<Result<AiSummary>> summary(String symbol, {bool regenerate = false}) async {
    final result = await guardApi(
      () => _cache.fetch(
        _Key.summary(symbol),
        ttl: _Ttl.summary,
        force: regenerate,
        load: () async => (await _remote.summary(symbol, refresh: regenerate)).toEntity(_now()),
      ),
    );
    return switch (result) {
      // A dropped connection on this POST is still just a failed read:
      // nothing changed, so it is safe to offer Retry, not "checking…".
      Err(failure: UnknownOutcomeFailure()) => const Err(TimeoutFailure()),
      // The server answers 400 when the stock has no fundamentals to read
      // (an ETF): nothing a retry can fix.
      Err(failure: ValidationFailure(:final message)) => Err(UnavailableFailure(message)),
      _ => result,
    };
  }

  @override
  Future<Result<Glossary>> glossary() => guardApi(
    () => _cache.fetch(
      _Key.glossary,
      ttl: _Ttl.glossary,
      load: () async => (await _remote.glossary()).toEntity(),
    ),
  );

  @override
  Glossary? cachedGlossary() => _cache.peek(_Key.glossary);
}
