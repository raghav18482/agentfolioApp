import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/logic/price_history_logic.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_portfolio_repository.dart';
import '../../helpers/fake_research_repository.dart';
import '../../helpers/recording_sink.dart';
import '../portfolio/portfolio_logic_test.dart' show holding;

void main() {
  late FakeResearchRepository research;
  late DateTime now;

  Future<StockDetailViewModel> vm({String symbol = 'RELIANCE-EQ'}) async {
    final (telemetry, _) = await recordingTelemetry();
    return StockDetailViewModel(
      symbol: symbol,
      research: research,
      portfolio: FakePortfolioRepository([
        holding('RELIANCE-EQ', invested: 900, pnl: 120),
        holding('TCS-EQ', invested: 1980),
      ]),
      telemetry: telemetry,
      clock: () => now,
    );
  }

  setUp(() {
    research = FakeResearchRepository();
    now = DateTime(2026, 3, 10, 12);
  });

  test('opening loads only the chart data; nothing slow or paid-for', () async {
    final model = await vm();
    await model.load();
    expect(research.calls, ['technicals']);
  });

  test('each tab loads its own data once, the first time it is shown', () async {
    final model = await vm();
    await model.load();
    model
      ..onTabShown(StockTab.fundamentals)
      ..onTabShown(StockTab.fundamentals)
      ..onTabShown(StockTab.ai)
      ..onTabShown(StockTab.technicals);
    await pumpEventQueue();
    expect(research.calls, ['technicals', 'fundamentals', 'glossary', 'summary']);
  });

  test('the prediction waits until its card is seen', () async {
    final model = await vm();
    await model.load();
    expect(research.calls, isNot(contains('prediction')));
    await model.revealPrediction();
    await model.revealPrediction();
    expect(research.calls.where((c) => c == 'prediction'), hasLength(1));
  });

  test('finds the holding, its portfolio weight, and prefers the broker LTP', () async {
    final model = await vm();
    await model.load();
    expect(model.holding?.symbol, 'RELIANCE-EQ');
    expect(model.portfolioWeight, closeTo(1020 / 3000, 1e-9));
    expect(model.lastPrice, 1020); // the holding's, not the technicals' 1010
    expect(model.dayMove, isNotNull);
  });

  test('a stock the user does not hold still works, priced from the last close', () async {
    final model = await vm(symbol: 'HDFCBANK-EQ');
    await model.load();
    expect(model.holding, isNull);
    expect(model.portfolioWeight, isNull);
    expect(model.lastPrice, 1010);
  });

  test('pull-to-refresh retries a failed section, and still never the unasked-for ones', () async {
    final model = await vm();
    research.fundamentalsResult = const Err(UnavailableFailure('No data found for X.NS'));
    await model.load();
    model.onTabShown(StockTab.fundamentals);
    await pumpEventQueue();
    research
      ..calls.clear()
      ..fundamentalsResult = const Err(NetworkFailure());
    await model.refresh();
    expect(research.calls, ['technicals', 'fundamentals']);
  });

  test('pull-to-refresh reloads what is on screen, never the paid AI summary', () async {
    final model = await vm();
    await model.load();
    model.onTabShown(StockTab.ai);
    await pumpEventQueue();
    research.calls.clear();
    await model.refresh();
    expect(research.calls, ['technicals']);
    expect(research.calls, isNot(contains('summary')));
  });

  group('regenerate', () {
    test('waits out the server cooldown after a fresh summary', () async {
      final model = await vm();
      research.summaryValue = () => AiSummary(markdown: 'x', cached: false, receivedAt: now);
      model.onTabShown(StockTab.ai);
      await pumpEventQueue();

      expect(model.regenerateAvailableAt, now.add(StockDetailViewModel.regenerateCooldown));
      await model.regenerateSummary();
      expect(research.calls, isNot(contains('summary:regenerate')));

      now = now.add(const Duration(seconds: 61));
      expect(model.regenerateAvailableAt, isNull);
      await model.regenerateSummary();
      expect(research.calls, contains('summary:regenerate'));
    });

    test('a summary served from the server cache can be regenerated at once', () async {
      final model = await vm();
      research.summaryValue = () => AiSummary(markdown: 'x', cached: true, receivedAt: now);
      model.onTabShown(StockTab.ai);
      await pumpEventQueue();
      expect(model.regenerateAvailableAt, isNull);
    });
  });

  test('range and chart style changes notify once, and repeats are ignored', () async {
    final model = await vm();
    var notified = 0;
    model
      ..addListener(() => notified++)
      ..setRange(ChartRange.year)
      ..setRange(ChartRange.year)
      ..setCandles(candles: true)
      ..setCandles(candles: true);
    expect(notified, 2);
    expect((model.range, model.showCandles), (ChartRange.year, true));
  });
}
