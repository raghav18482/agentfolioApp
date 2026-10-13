import 'package:agentfolio/features/portfolio/data/models/portfolio_dtos.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/logic/portfolio_insights.dart';
import 'package:flutter_test/flutter_test.dart';

Holding holding(String symbol, {double invested = 100, double pnl = 0, double? current}) => Holding(
  symbol: symbol,
  brokerToken: '1',
  quantity: 1,
  averagePrice: invested,
  lastPrice: current ?? invested + pnl,
  invested: invested,
  currentValue: current ?? invested + pnl,
  pnl: pnl,
  pnlPercent: invested == 0 ? 0 : pnl / invested * 100,
);

void main() {
  group('top movers', () {
    test('gainers and losers never include the other side', () {
      final movers = topMovers([
        holding('A-EQ', pnl: 50),
        holding('B-EQ', pnl: -20),
        holding('C-EQ', pnl: 5),
        holding('D-EQ'),
      ]);
      expect(movers.gainers.map((h) => h.symbol), ['A-EQ', 'C-EQ']);
      expect(movers.losers.map((h) => h.symbol), ['B-EQ']);
    });

    test('at most five each, biggest first', () {
      final many = [for (var i = 1; i <= 8; i++) holding('G$i', pnl: i * 10.0)];
      expect(topMovers(many).gainers.map((h) => h.pnl), [80, 70, 60, 50, 40]);
    });
  });

  group('sectors', () {
    test('unmapped holdings count as Other and slices sum to the whole', () {
      final slices = sectorSlices(
        [holding('TCS-EQ', invested: 300), holding('INFY-EQ', invested: 200), holding('ZZZ-EQ')],
        {'TCS-EQ': 'IT', 'INFY-EQ': 'IT'},
      );
      expect(slices.first, (sector: 'IT', value: 500.0));
      expect(slices.last, (sector: 'Other', value: 100.0));
    });

    test('small slices fold into Other so the donut stays readable', () {
      final slices = [for (var i = 0; i < 10; i++) (sector: 'S$i', value: 100.0 - i)];
      final folded = foldSmallSlices(slices, max: 5);
      expect(folded, hasLength(5));
      expect(folded.last.sector, 'Other');
      final before = slices.fold<double>(0, (s, x) => s + x.value);
      final after = folded.fold<double>(0, (s, x) => s + x.value);
      expect(after, before);
    });
  });

  test('holdings search and sort', () {
    final list = [
      holding('TCS-EQ', invested: 300),
      holding('INFY-EQ', invested: 500),
      holding('ITC-EQ'),
    ];
    expect(arrangeHoldings(list, sort: HoldingSort.currentValue).map((h) => h.displaySymbol), [
      'INFY',
      'TCS',
      'ITC',
    ]);
    expect(arrangeHoldings(list, sort: HoldingSort.name).first.displaySymbol, 'INFY');
    expect(arrangeHoldings(list, sort: HoldingSort.name, query: 'it').map((h) => h.displaySymbol), [
      'ITC',
    ]);
  });

  test('order states group the broker statuses', () {
    Order order(String status) => Order(
      orderId: '1',
      symbol: 'X',
      side: OrderSide.buy,
      quantity: 1,
      price: 1,
      status: status,
      time: '',
    );
    expect(order('complete').state, OrderState.complete);
    expect(order('Rejected').state, OrderState.closed);
    expect(order('trigger pending').state, OrderState.pending);
  });

  test('beta bands', () {
    expect(BetaBand.of(1.3), BetaBand.aggressive);
    expect(BetaBand.of(1), BetaBand.market);
    expect(BetaBand.of(0.5), BetaBand.defensive);
  });

  group('DTO parsing tolerates the broker', () {
    test('funds as strings or N/A, missing summary', () {
      final snapshot = PortfolioDto.fromJson({
        'holdings': [
          {
            'symbol': 'TCS-EQ',
            'symboltoken': 11536,
            'qty': '5',
            'avg_price': '3000.5',
            'ltp': 3100,
            'invested': 15002.5,
            'current': 15500,
            'pnl': 497.5,
            'pnl_pct': 3.32,
          },
        ],
        'funds': {'available_cash': '1200.50', 'net': 'N/A'},
      }).toEntity(DateTime(2026));
      expect(snapshot.holdings.single.quantity, 5);
      expect(snapshot.holdings.single.brokerToken, '11536');
      expect(snapshot.funds.availableCash, 1200.5);
      expect(snapshot.funds.net, isNull);
      expect(snapshot.summary.currentValue, isNull);
    });

    test('benchmark series of different lengths are trimmed to match', () {
      final b = BenchmarkDto.fromJson({
        'beta': 1.1,
        'alpha': 0.0002,
        'r_squared': 0.8,
        'dates': ['2026-01-01', '2026-01-02', '2026-01-03'],
        'nifty_cumulative': [0, 1.2],
        'portfolio_cumulative': [0, 0.5, 0.9],
        'stock_betas': [
          {'symbol': 'TCS-EQ', 'beta': 0.7},
        ],
        'days_used': 60,
      }).toEntity();
      expect(b.dates, hasLength(2));
      expect(b.portfolioCumulative, [0, 0.5]);
      expect(b.stockBetas.single.symbol, 'TCS-EQ');
    });
  });
}
