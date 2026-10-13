import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/trading/data/datasources/trading_remote_data_source.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/repositories/trading_repository.dart';

/// Keys start `trading/`, so an agent reply that may have created or settled
/// a proposal can drop them all at once.
abstract final class _Key {
  static const profile = 'trading/profile';
  static const proposals = 'trading/proposals';
  static const schedule = 'trading/briefing/schedule';
  static const logs = 'trading/briefing/logs';
}

abstract final class _Ttl {
  static const profile = Duration(minutes: 30);

  /// Polled every few seconds while on screen; this only shares one answer
  /// between the cards that read it.
  static const proposals = Duration(seconds: 5);
  static const schedule = Duration(minutes: 10);
  static const logs = Duration(minutes: 1);
}

class TradingRepositoryImpl implements TradingRepository {
  TradingRepositoryImpl(this._remote, this._cache);

  final TradingRemoteDataSource _remote;
  final RequestCache _cache;

  @override
  Future<Result<RiskProfile?>> riskProfile({bool force = false}) => guardApi(
    () => _cache.fetch(_Key.profile, ttl: _Ttl.profile, force: force, load: _remote.riskProfile),
  );

  @override
  Future<Result<RiskProfile>> saveRiskProfile(RiskProfile profile) async {
    final result = await guardApi(() => _remote.saveRiskProfile(profile));
    if (result case Success(:final value)) _cache.put<RiskProfile?>(_Key.profile, value);
    return result;
  }

  @override
  Future<Result<List<TradeProposal>>> proposals({bool force = false}) => guardApi(
    () => _cache.fetch(_Key.proposals, ttl: _Ttl.proposals, force: force, load: _remote.proposals),
  );

  @override
  List<TradeProposal>? cachedProposals() => _cache.peek(_Key.proposals);

  @override
  Future<Result<ExecutionResult>> approve(String proposalId) async {
    final result = await guardApi(() => _remote.approve(proposalId));
    _cache.invalidate(_Key.proposals);
    return result;
  }

  @override
  Future<Result<void>> reject(String proposalId) async {
    final result = await guardApi(() => _remote.reject(proposalId));
    _cache.invalidate(_Key.proposals);
    return result;
  }

  @override
  Future<Result<BriefingSchedule?>> briefingSchedule({bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.schedule,
      ttl: _Ttl.schedule,
      force: force,
      load: _remote.briefingSchedule,
    ),
  );

  @override
  Future<Result<BriefingSchedule>> saveBriefingSchedule({
    required String timeIst,
    required bool enabled,
  }) async {
    final result = await guardApi(() => _remote.saveBriefingSchedule(timeIst, enabled: enabled));
    if (result case Success(:final value)) _cache.put<BriefingSchedule?>(_Key.schedule, value);
    return result;
  }

  @override
  Future<Result<void>> disableBriefing() async {
    final result = await guardApi(_remote.disableBriefing);
    _cache.invalidate(_Key.schedule);
    return result;
  }

  @override
  Future<Result<String>> sendBriefingNow() => guardApi(_remote.sendBriefingNow);

  @override
  Future<Result<List<BriefingLog>>> briefingLogs({bool force = false}) => guardApi(
    () => _cache.fetch(_Key.logs, ttl: _Ttl.logs, force: force, load: _remote.briefingLogs),
  );

  @override
  Future<Result<void>> activatePremium({required String dialCode, required String number}) =>
      guardApi(() => _remote.activatePremium(dialCode, number));
}
