import 'package:freezed_annotation/freezed_annotation.dart';

part 'trading.freezed.dart';

/// The goals the server's risk profile accepts. Note the space in the wire
/// value of [wealthCreation].
enum InvestmentGoal {
  wealthCreation('wealth creation'),
  income('income'),
  preservation('preservation'),
  speculation('speculation');

  InvestmentGoal(this.wire);
  final String wire;
}

enum RiskTolerance { low, medium, high }

enum ProductType {
  delivery('DELIVERY'),
  intraday('INTRADAY');

  ProductType(this.wire);
  final String wire;
}

/// The user's stated appetite. The server checks every order against it
/// before anything reaches the broker.
@freezed
abstract class RiskProfile with _$RiskProfile {
  const factory RiskProfile({
    required int age,
    required InvestmentGoal goal,
    required int horizonYears,
    required RiskTolerance tolerance,
    required String taxBracket,
    required double maxOrderValue,
    required double maxPositionPercent,
    required int maxDailyTrades,
    required Set<ProductType> products,
  }) = _RiskProfile;

  /// What a first-time form starts with: the web app's defaults.
  static const starter = RiskProfile(
    age: 24,
    goal: InvestmentGoal.wealthCreation,
    horizonYears: 10,
    tolerance: RiskTolerance.high,
    taxBracket: '20%',
    maxOrderValue: 500000,
    maxPositionPercent: 35,
    maxDailyTrades: 25,
    products: {ProductType.delivery, ProductType.intraday},
  );
}

enum ProposalStatus { pending, approved, rejected, expired, executed, failed, unknown }

enum TradeSide { buy, sell }

/// The order a proposal would place, read from the broker parameters the
/// agent wrote. Values arrive as strings and are parsed leniently.
@freezed
abstract class ProposedOrder with _$ProposedOrder {
  const factory ProposedOrder({
    required String symbol,
    required TradeSide side,
    required int quantity,

    /// Null for a market order.
    double? price,
    double? triggerPrice,
    @Default('') String orderType,
    @Default('') String product,
    @Default('NSE') String exchange,
    String? symbolToken,
  }) = _ProposedOrder;
}

@freezed
abstract class TradeProposal with _$TradeProposal {
  const factory TradeProposal({
    required String id,
    required ProposalStatus status,
    required String summary,
    required ProposedOrder order,

    /// Server time.
    required DateTime createdAt,
    required Duration ttl,
    String? orderId,
    String? error,
  }) = _TradeProposal;

  const TradeProposal._();

  /// Server time.
  DateTime get expiresAt => createdAt.add(ttl);

  bool get isPending => status == ProposalStatus.pending;
}

/// The broker's answer to an approval. A risk or compliance block is still
/// a 200, with `ok: false` and the reason.
@freezed
abstract class ExecutionResult with _$ExecutionResult {
  const factory ExecutionResult({required bool ok, String? orderId, String? error}) =
      _ExecutionResult;
}

@freezed
abstract class BriefingSchedule with _$BriefingSchedule {
  const factory BriefingSchedule({
    required int id,
    required bool enabled,
    DateTime? nextRun,
    DateTime? lastRun,

    /// `pending`, `running`, …
    @Default('pending') String status,
  }) = _BriefingSchedule;
}

enum BriefingOutcome { success, running, failed }

@freezed
abstract class BriefingLog with _$BriefingLog {
  const factory BriefingLog({
    required int id,
    required BriefingOutcome outcome,
    @Default('') String message,
    Duration? duration,
    DateTime? at,
  }) = _BriefingLog;
}
