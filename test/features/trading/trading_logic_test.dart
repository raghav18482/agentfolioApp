import 'package:agentfolio/features/trading/data/models/trading_dtos.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_trading.dart';

void main() {
  final t0 = DateTime.utc(2026, 10, 12, 5);

  group('proposals', () {
    test('time left runs on server time and stops at zero', () {
      final p = proposal('a', createdAt: t0);
      expect(timeLeft(p, t0.add(const Duration(minutes: 1))), const Duration(minutes: 4));
      expect(timeLeft(p, t0.add(const Duration(minutes: 9))), Duration.zero);
    });

    test('pending first, soonest to expire on top; the rest newest first', () {
      final sorted = sortProposals([
        proposal('old-done', status: ProposalStatus.executed, createdAt: t0),
        proposal('late', createdAt: t0.add(const Duration(minutes: 2))),
        proposal(
          'new-done',
          status: ProposalStatus.rejected,
          createdAt: t0.add(const Duration(minutes: 3)),
        ),
        proposal('soon', createdAt: t0),
      ]);
      expect(sorted.map((p) => p.id), ['soon', 'late', 'new-done', 'old-done']);
    });

    test('order value uses the limit price, else the latest price', () {
      final limit = proposal('a', price: 100).order;
      final market = proposal('b', price: null).order;
      expect(orderValue(limit), 1000);
      expect(orderValue(market), isNull);
      expect(orderValue(market, lastPrice: 95), 950);
    });
  });

  group('approval outcomes', () {
    test('a direct answer: ok means placed, otherwise the reason', () {
      expect(outcomeOf(const ExecutionResult(ok: true, orderId: '9')), isA<OrderPlaced>());
      final blocked = outcomeOf(const ExecutionResult(ok: false, error: 'Risk check failed: x'));
      expect((blocked as OrderNotPlaced).reason, 'Risk check failed: x');
    });

    test('a lost answer is settled from what the server now reports', () {
      ApprovalOutcome after(ProposalStatus s) => reconcileApproval(proposal('a', status: s));
      expect(after(ProposalStatus.executed), isA<OrderPlaced>());
      expect(after(ProposalStatus.failed), isA<OrderNotPlaced>());
      expect(after(ProposalStatus.approved), isA<OrderInProgress>());
      expect(after(ProposalStatus.pending), isA<ApprovalNotReceived>());
      expect(after(ProposalStatus.expired), isA<OrderNotPlaced>());
      expect(reconcileApproval(null), isA<OutcomeUnconfirmed>());
    });
  });

  test('profile limits match the web form', () {
    Set<ProfileField> check({
      int? age = 30,
      int? horizon = 10,
      double? order = 50000,
      double? position = 20,
      int? trades = 5,
      Set<ProductType> products = const {ProductType.delivery},
    }) => profileProblems(
      age: age,
      horizonYears: horizon,
      maxOrderValue: order,
      maxPositionPercent: position,
      maxDailyTrades: trades,
      products: products,
    );
    expect(check(), isEmpty);
    expect(check(age: 17), {ProfileField.age});
    expect(check(age: null), {ProfileField.age});
    expect(check(horizon: 51), {ProfileField.horizon});
    expect(check(order: 999), {ProfileField.maxOrderValue});
    expect(check(position: 0), {ProfileField.maxPosition});
    expect(check(trades: 101), {ProfileField.maxDailyTrades});
    expect(check(products: {}), {ProfileField.products});
  });

  group('rebalancer (ported from rebalance.test.ts)', () {
    ({String symbol, String label, double value}) h(String s, double v) =>
        (symbol: s, label: s.replaceAll('-EQ', ''), value: v);

    test('keeps the largest holdings, biggest first, and drops empty ones', () {
      final rows = rebalanceRows([
        for (var i = 0; i < 15; i++) h('S$i-EQ', (i + 1) * 100.0),
        h('ZERO-EQ', 0),
      ]);
      expect(rows, hasLength(maxRebalanceRows));
      expect(rows.first.symbol, 'S14-EQ');
      expect(rows.first.label, 'S14');
      expect(rows.any((r) => r.symbol == 'ZERO-EQ'), isFalse);
    });

    final rows = rebalanceRows([h('A-EQ', 1000), h('B-EQ', 500)]);

    test('frees cash in proportion to the percent sold', () {
      final s = simulate(rows, {'A-EQ': 50, 'B-EQ': 100}, {}, 200);
      expect(s.freed, 1000);
      expect(s.after, {'A-EQ': 500, 'B-EQ': 0});
      expect(s.remaining, 1200);
    });

    test('keeps reinvestments when a slider moves afterwards', () {
      final buys = {'B-EQ': 300.0};
      expect(simulate(rows, {'A-EQ': 50}, buys, 0).after['B-EQ'], 800);
      final moved = simulate(rows, {'A-EQ': 80}, buys, 0);
      expect(moved.after['B-EQ'], 800);
      expect(moved.remaining, 500);
    });

    test('rejects zero, negative, NaN and more than is left', () {
      expect(canReinvest(100, 100), isTrue);
      expect(canReinvest(101, 100), isFalse);
      expect(canReinvest(0, 100), isFalse);
      expect(canReinvest(-5, 100), isFalse);
      expect(canReinvest(double.nan, 100), isFalse);
    });
  });

  group('wire formats', () {
    test("a proposal exactly as the agent's tool writes it", () {
      final p = proposalFromJson({
        'proposal_id': 'a1b2c3d4e5f6',
        'status': 'pending',
        'summary': 'BUY 5 RELIANCE-EQ @ market DELIVERY (NSE)',
        'order_params': {
          'variety': 'NORMAL',
          'tradingsymbol': 'RELIANCE-EQ',
          'symboltoken': '2885',
          'transactiontype': 'BUY',
          'exchange': 'NSE',
          'ordertype': 'MARKET',
          'producttype': 'DELIVERY',
          'duration': 'DAY',
          'price': '0',
          'triggerprice': '0',
          'quantity': '5',
        },
        'created_at': 1791820000.25,
        'ttl_seconds': 300,
        'order_id': null,
        'error': null,
      });
      expect(p.order.symbol, 'RELIANCE-EQ');
      expect(p.order.side, TradeSide.buy);
      expect(p.order.quantity, 5);
      expect(p.order.price, isNull, reason: '"0" is a market order');
      expect(p.order.symbolToken, '2885');
      expect(p.createdAt.millisecondsSinceEpoch, 1791820000250);
      expect(p.expiresAt.difference(p.createdAt), const Duration(minutes: 5));
    });

    test('a status the app does not know is shown as unknown, not a crash', () {
      final p = proposalFromJson({'proposal_id': 'x', 'status': 'queued', 'created_at': 0});
      expect(p.status, ProposalStatus.unknown);
      expect(p.order.quantity, 0);
    });

    test('the risk profile round-trips in the shape the server validates', () {
      final json = riskProfileToJson(RiskProfile.starter);
      expect(json['goal'], 'wealth creation');
      expect(json['risk_tolerance'], 'high');
      expect(json['allowed_products'], ['DELIVERY', 'INTRADAY']);
      expect(riskProfileFromMap(json), RiskProfile.starter);
      expect(riskProfileFromJson({'has_profile': false}), isNull);
    });

    test('briefing logs drop the "manual send" prefix and parse UTC times', () {
      final log = briefingLogFromJson({
        'id': 3,
        'status': 'success',
        'message': 'manual send · 812 chars to +91…',
        'duration_ms': 21400,
        'created_at': '2026-10-12T03:00:05',
      });
      expect(log.outcome, BriefingOutcome.success);
      expect(log.message, '812 chars to +91…');
      expect(log.duration, const Duration(milliseconds: 21400));
      expect(log.at, DateTime.utc(2026, 10, 12, 3, 0, 5));
    });
  });
}
