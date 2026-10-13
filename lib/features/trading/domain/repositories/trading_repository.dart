import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';

/// The trading workspace: risk profile, the agent's proposals, the daily
/// WhatsApp brief and Premium activation.
abstract interface class TradingRepository {
  /// Null when the user has not set one yet.
  Future<Result<RiskProfile?>> riskProfile({bool force = false});
  Future<Result<RiskProfile>> saveRiskProfile(RiskProfile profile);

  Future<Result<List<TradeProposal>>> proposals({bool force = false});
  List<TradeProposal>? cachedProposals();

  /// Approves and executes in one call: places a REAL order when the result
  /// is `ok`. Never retried; a lost answer is an unknown outcome.
  Future<Result<ExecutionResult>> approve(String proposalId);
  Future<Result<void>> reject(String proposalId);

  /// Null when no schedule was ever saved.
  Future<Result<BriefingSchedule?>> briefingSchedule({bool force = false});
  Future<Result<BriefingSchedule>> saveBriefingSchedule({
    required String timeIst,
    required bool enabled,
  });
  Future<Result<void>> disableBriefing();

  /// Starts a send in the background; the result lands in the logs later.
  Future<Result<String>> sendBriefingNow();
  Future<Result<List<BriefingLog>>> briefingLogs({bool force = false});

  Future<Result<void>> activatePremium({required String dialCode, required String number});
}
