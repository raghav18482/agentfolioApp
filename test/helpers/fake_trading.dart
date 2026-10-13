import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/repositories/trading_repository.dart';

class FakeDeviceAuth implements DeviceAuth {
  FakeDeviceAuth([this.result = DeviceAuthResult.confirmed]);

  DeviceAuthResult result;
  final reasons = <String>[];

  @override
  Future<DeviceAuthResult> confirm(String reason) async {
    reasons.add(reason);
    return result;
  }
}

TradeProposal proposal(
  String id, {
  ProposalStatus status = ProposalStatus.pending,
  DateTime? createdAt,
  Duration ttl = const Duration(minutes: 5),
  TradeSide side = TradeSide.buy,
  int quantity = 10,
  double? price = 3500,
  String symbol = 'TCS-EQ',
  String? orderId,
  String? error,
}) => TradeProposal(
  id: id,
  status: status,
  summary: '${side.name.toUpperCase()} $quantity $symbol',
  order: ProposedOrder(
    symbol: symbol,
    side: side,
    quantity: quantity,
    price: price,
    orderType: price == null ? 'MARKET' : 'LIMIT',
    product: 'DELIVERY',
  ),
  createdAt: createdAt ?? DateTime.now().toUtc(),
  ttl: ttl,
  orderId: orderId,
  error: error,
);

/// A trading backend whose answers each test sets. Approving moves the
/// proposal along as the server would.
class FakeTradingRepository implements TradingRepository {
  FakeTradingRepository({List<TradeProposal>? proposals}) : list = proposals ?? [];

  List<TradeProposal> list;
  final calls = <String>[];

  RiskProfile? profile;
  Result<RiskProfile>? saveFailure;

  /// What approving returns; by default the order is placed.
  Result<ExecutionResult> Function(String id)? onApprove;
  Result<List<TradeProposal>>? proposalsFailure;
  Completer<void>? approveGate;

  BriefingSchedule? schedule;
  List<BriefingLog> logs = [];
  Result<void>? premiumResult;

  void settle(String id, ProposalStatus status, {String? orderId, String? error}) {
    list = [
      for (final p in list)
        if (p.id == id) p.copyWith(status: status, orderId: orderId, error: error) else p,
    ];
  }

  @override
  Future<Result<RiskProfile?>> riskProfile({bool force = false}) async {
    calls.add('profile');
    return Success(profile);
  }

  @override
  Future<Result<RiskProfile>> saveRiskProfile(RiskProfile p) async {
    calls.add('saveProfile');
    if (saveFailure case final f?) return f;
    profile = p;
    return Success(p);
  }

  @override
  Future<Result<List<TradeProposal>>> proposals({bool force = false}) async {
    calls.add('proposals');
    return proposalsFailure ?? Success([...list]);
  }

  @override
  List<TradeProposal>? cachedProposals() => null;

  @override
  Future<Result<ExecutionResult>> approve(String id) async {
    calls.add('approve:$id');
    await approveGate?.future;
    final result = onApprove?.call(id) ?? const Success(ExecutionResult(ok: true, orderId: 'ORD1'));
    if (result case Success(:final value)) {
      settle(
        id,
        value.ok ? ProposalStatus.executed : ProposalStatus.failed,
        orderId: value.orderId,
        error: value.error,
      );
    }
    return result;
  }

  @override
  Future<Result<void>> reject(String id) async {
    calls.add('reject:$id');
    settle(id, ProposalStatus.rejected);
    return const Success(null);
  }

  @override
  Future<Result<BriefingSchedule?>> briefingSchedule({bool force = false}) async {
    calls.add('schedule');
    return Success(schedule);
  }

  @override
  Future<Result<BriefingSchedule>> saveBriefingSchedule({
    required String timeIst,
    required bool enabled,
  }) async {
    calls.add('saveSchedule:$timeIst:$enabled');
    final [h, m] = timeIst.split(':').map(int.parse).toList();
    // 08:30 IST is 03:00 UTC.
    final next = DateTime.utc(2026, 10, 13, h, m).subtract(const Duration(hours: 5, minutes: 30));
    schedule = BriefingSchedule(id: 1, enabled: enabled, nextRun: next);
    return Success(schedule!);
  }

  @override
  Future<Result<void>> disableBriefing() async {
    calls.add('disableSchedule');
    schedule = schedule?.copyWith(enabled: false);
    return const Success(null);
  }

  @override
  Future<Result<String>> sendBriefingNow() async {
    calls.add('sendNow');
    return const Success('Briefing started — check WhatsApp in ~30s');
  }

  @override
  Future<Result<List<BriefingLog>>> briefingLogs({bool force = false}) async {
    calls.add('logs');
    return Success(logs);
  }

  @override
  Future<Result<void>> activatePremium({required String dialCode, required String number}) async {
    calls.add('premium:$dialCode:$number');
    return premiumResult ?? const Success(null);
  }
}

Result<ExecutionResult> lostApproval(String _) => const Err(UnknownOutcomeFailure());
