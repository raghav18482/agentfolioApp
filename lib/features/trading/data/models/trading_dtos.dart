import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';

// Hand-written mappers: these payloads mix types freely (order params are
// all strings, epoch seconds are floats), and every field is read leniently.

RiskProfile? riskProfileFromJson(JsonMap json) {
  if (json['has_profile'] != true || json['profile'] is! Map) return null;
  return riskProfileFromMap(asJsonMap(json['profile']));
}

RiskProfile riskProfileFromMap(JsonMap p) {
  final goal = jsonString(p['goal']).toLowerCase();
  final tolerance = jsonString(p['risk_tolerance']).toLowerCase();
  return RiskProfile(
    age: jsonInt(p['age']),
    goal:
        InvestmentGoal.values.where((g) => g.wire == goal).firstOrNull ??
        InvestmentGoal.wealthCreation,
    horizonYears: jsonInt(p['horizon_years']),
    tolerance:
        RiskTolerance.values.where((t) => t.name == tolerance).firstOrNull ?? RiskTolerance.medium,
    taxBracket: jsonString(p['tax_bracket']),
    maxOrderValue: jsonNum(p['max_single_order_value']),
    maxPositionPercent: jsonNum(p['max_position_pct']),
    maxDailyTrades: jsonInt(p['max_daily_trades']),
    products: {
      for (final raw in jsonStringList(p['allowed_products']))
        ?ProductType.values.where((x) => x.wire == raw.toUpperCase()).firstOrNull,
    },
  );
}

JsonMap riskProfileToJson(RiskProfile p) => {
  'age': p.age,
  'goal': p.goal.wire,
  'horizon_years': p.horizonYears,
  'risk_tolerance': p.tolerance.name,
  'tax_bracket': p.taxBracket.trim(),
  'max_single_order_value': p.maxOrderValue,
  'max_position_pct': p.maxPositionPercent,
  'max_daily_trades': p.maxDailyTrades,
  // In a fixed order, so the same profile always sends the same body.
  'allowed_products': [
    for (final x in ProductType.values)
      if (p.products.contains(x)) x.wire,
  ],
};

ProposedOrder proposedOrderFromJson(Object? raw) {
  final p = raw is Map ? asJsonMap(raw) : const <String, Object?>{};
  final price = jsonNumOrNull(p['price']);
  final trigger = jsonNumOrNull(p['triggerprice']);
  return ProposedOrder(
    symbol: jsonString(p['tradingsymbol'] ?? p['symbol']),
    side: jsonString(p['transactiontype']).toUpperCase() == 'SELL' ? TradeSide.sell : TradeSide.buy,
    quantity: jsonInt(p['quantity']),
    // The agent writes "0" for a market order.
    price: price == null || price <= 0 ? null : price,
    triggerPrice: trigger == null || trigger <= 0 ? null : trigger,
    orderType: jsonString(p['ordertype']).toUpperCase(),
    product: jsonString(p['producttype']).toUpperCase(),
    exchange: jsonStringOrNull(p['exchange'])?.toUpperCase() ?? 'NSE',
    symbolToken: jsonStringOrNull(p['symboltoken']),
  );
}

TradeProposal proposalFromJson(JsonMap p) {
  final status = jsonString(p['status']).toLowerCase();
  final seconds = jsonNum(p['created_at']);
  return TradeProposal(
    id: jsonString(p['proposal_id']),
    status:
        ProposalStatus.values.where((s) => s.name == status).firstOrNull ?? ProposalStatus.unknown,
    summary: jsonString(p['summary']),
    order: proposedOrderFromJson(p['order_params']),
    createdAt: DateTime.fromMillisecondsSinceEpoch((seconds * 1000).round(), isUtc: true),
    ttl: Duration(seconds: jsonInt(p['ttl_seconds'] ?? 300)),
    orderId: jsonStringOrNull(p['order_id']),
    error: jsonStringOrNull(p['error']),
  );
}

ExecutionResult executionResultFromJson(JsonMap p) => ExecutionResult(
  ok: p['ok'] == true,
  orderId: jsonStringOrNull(p['order_id']),
  error: jsonStringOrNull(p['error']),
);

BriefingSchedule? briefingScheduleFromJson(JsonMap json) {
  if (json['exists'] != true || json['schedule'] is! Map) return null;
  return briefingScheduleFromMap(asJsonMap(json['schedule']));
}

BriefingSchedule briefingScheduleFromMap(JsonMap s) => BriefingSchedule(
  id: jsonInt(s['id']),
  enabled: s['enabled'] == true,
  nextRun: Times.parseServer(jsonStringOrNull(s['next_run'])),
  lastRun: Times.parseServer(jsonStringOrNull(s['last_run'])),
  status: jsonStringOrNull(s['status']) ?? 'pending',
);

BriefingLog briefingLogFromJson(JsonMap l) {
  final ms = jsonNumOrNull(l['duration_ms']);
  return BriefingLog(
    id: jsonInt(l['id']),
    outcome: switch (jsonString(l['status']).toLowerCase()) {
      'success' => BriefingOutcome.success,
      'running' => BriefingOutcome.running,
      _ => BriefingOutcome.failed,
    },
    message: jsonString(l['message']).replaceFirst('manual send · ', ''),
    duration: ms == null || ms <= 0 ? null : Duration(milliseconds: ms.round()),
    at: Times.parseServer(jsonStringOrNull(l['created_at'])),
  );
}
