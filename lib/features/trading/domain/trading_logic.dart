import 'package:agentfolio/features/trading/domain/entities/trading.dart';

/// How long until a pending proposal expires, by the server's clock. Zero
/// once it has.
Duration timeLeft(TradeProposal p, DateTime serverNow) {
  final left = p.expiresAt.difference(serverNow);
  return left.isNegative ? Duration.zero : left;
}

/// Pending first, soonest to expire on top (they need a decision); then the
/// rest, newest first.
List<TradeProposal> sortProposals(List<TradeProposal> proposals) {
  final pending = [
    for (final p in proposals)
      if (p.isPending) p,
  ]..sort((a, b) => a.expiresAt.compareTo(b.expiresAt));
  final rest = [
    for (final p in proposals)
      if (!p.isPending) p,
  ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return [...pending, ...rest];
}

/// The order's rough value: its limit price, else the latest price known.
double? orderValue(ProposedOrder order, {double? lastPrice}) {
  final price = order.price ?? lastPrice;
  return price == null ? null : price * order.quantity;
}

/// What happened to an approval, as far as the app can tell.
sealed class ApprovalOutcome {
  const ApprovalOutcome();
}

/// The broker accepted the order.
final class OrderPlaced extends ApprovalOutcome {
  const OrderPlaced(this.orderId);
  final String? orderId;
}

/// Checked and refused (risk profile, compliance, the broker): nothing was
/// placed.
final class OrderNotPlaced extends ApprovalOutcome {
  const OrderNotPlaced(this.reason);
  final String reason;
}

/// The approval never reached the server; it is still pending and may be
/// approved again.
final class ApprovalNotReceived extends ApprovalOutcome {
  const ApprovalNotReceived();
}

/// Approved, and with the broker: the result is not back yet. Check Orders.
final class OrderInProgress extends ApprovalOutcome {
  const OrderInProgress();
}

/// The proposal is gone (the server restarted, or it expired long ago), so
/// the outcome cannot be confirmed. Check Orders before doing anything else.
final class OutcomeUnconfirmed extends ApprovalOutcome {
  const OutcomeUnconfirmed();
}

/// Turns the direct answer to an approval into an outcome.
ApprovalOutcome outcomeOf(ExecutionResult result) => result.ok
    ? OrderPlaced(result.orderId)
    : OrderNotPlaced(result.error ?? 'The order was not placed.');

/// Works out what happened to an approval whose answer was lost, from the
/// proposal as the server now reports it. The server refuses to approve a
/// proposal twice, so this never risks a second order.
ApprovalOutcome reconcileApproval(TradeProposal? now) => switch (now?.status) {
  null || ProposalStatus.unknown => const OutcomeUnconfirmed(),
  ProposalStatus.executed => OrderPlaced(now!.orderId),
  ProposalStatus.failed => OrderNotPlaced(now!.error ?? 'The order was not placed.'),
  ProposalStatus.approved => const OrderInProgress(),
  ProposalStatus.pending => const ApprovalNotReceived(),
  ProposalStatus.rejected => const OrderNotPlaced('The proposal was rejected.'),
  ProposalStatus.expired => const OrderNotPlaced('The proposal expired before it was approved.'),
};

/// One field of the risk profile form that needs fixing.
enum ProfileField { age, horizon, maxOrderValue, maxPosition, maxDailyTrades, products }

/// The limits the web form enforces, checked before saving.
Set<ProfileField> profileProblems({
  required int? age,
  required int? horizonYears,
  required double? maxOrderValue,
  required double? maxPositionPercent,
  required int? maxDailyTrades,
  required Set<ProductType> products,
}) => {
  if (age == null || age < 18 || age > 120) ProfileField.age,
  if (horizonYears == null || horizonYears < 1 || horizonYears > 50) ProfileField.horizon,
  if (maxOrderValue == null || maxOrderValue < 1000) ProfileField.maxOrderValue,
  if (maxPositionPercent == null || maxPositionPercent < 1 || maxPositionPercent > 100)
    ProfileField.maxPosition,
  if (maxDailyTrades == null || maxDailyTrades < 1 || maxDailyTrades > 100)
    ProfileField.maxDailyTrades,
  if (products.isEmpty) ProfileField.products,
};

/// `HH:MM` in India time, the form the briefing endpoint takes.
String istHhMm(int hour, int minute) =>
    '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

// ── What-if rebalancer ──────────────────────────────────────────────────────
// Ported from AgentfolioUI/src/lib/rebalance.ts. Nothing here is ever sent to
// the broker.

class RebalanceRow {
  const RebalanceRow({required this.symbol, required this.label, required this.original});

  final String symbol;
  final String label;
  final double original;
}

/// The biggest holdings: small ones barely move the picture.
const maxRebalanceRows = 12;

List<RebalanceRow> rebalanceRows(Iterable<({String symbol, String label, double value})> holdings) {
  final rows = [
    for (final h in holdings)
      if (h.value > 0) RebalanceRow(symbol: h.symbol, label: h.label, original: h.value),
  ]..sort((a, b) => b.original.compareTo(a.original));
  return rows.take(maxRebalanceRows).toList();
}

class Simulation {
  const Simulation({required this.after, required this.freed, required this.remaining});

  /// Each row's value after selling and reinvesting.
  final Map<String, double> after;
  final double freed;

  /// Cash still to deploy: what was there, plus what was freed, minus what
  /// was reinvested.
  final double remaining;
}

/// [sells] is percent sold per symbol; [buys] rupees added per symbol.
Simulation simulate(
  List<RebalanceRow> rows,
  Map<String, double> sells,
  Map<String, double> buys,
  double cash,
) {
  final after = <String, double>{};
  var freed = 0.0;
  var bought = 0.0;
  for (final r in rows) {
    final sold = r.original * ((sells[r.symbol] ?? 0) / 100);
    final added = buys[r.symbol] ?? 0;
    freed += sold;
    bought += added;
    after[r.symbol] = r.original - sold + added;
  }
  return Simulation(after: after, freed: freed, remaining: cash + freed - bought);
}

/// Checked against the cash still unspent, so two reinvestments cannot
/// together exceed what there is.
bool canReinvest(double amount, double remaining) =>
    amount.isFinite && amount > 0 && amount <= remaining + 1e-6;
