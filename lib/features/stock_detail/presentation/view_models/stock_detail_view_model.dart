import 'dart:async';

import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/logic/price_history_logic.dart';
import 'package:agentfolio/features/research/domain/repositories/research_repository.dart';
import 'package:collection/collection.dart';

enum StockTab { overview, fundamentals, technicals, ai }

/// One stock, from any list in the app: chart, position, outlook,
/// fundamentals, technicals and the AI reading.
///
/// Each source loads when it is first needed, not up front:
/// * technicals (chart, indicators) and the portfolio, on open; the
///   portfolio is usually already cached by Home;
/// * the prediction, when its card scrolls into view;
/// * fundamentals and the glossary, when their tab is first shown (Yahoo is
///   slow);
/// * the AI summary, when its tab is first shown (the server pays for it).
class StockDetailViewModel extends BaseViewModel {
  StockDetailViewModel({
    required this.symbol,
    required this._research,
    required this._portfolio,
    required super.telemetry,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  /// The broker's trading symbol, e.g. `RELIANCE-EQ`.
  final String symbol;
  final ResearchRepository _research;
  final PortfolioRepository _portfolio;
  final DateTime Function() _now;

  /// The server makes a regenerate within this long of the last generation
  /// return the same text, so the button says so instead of pretending.
  static const regenerateCooldown = Duration(seconds: 60);

  late final technicals = Loadable<Technicals>(
    fetch: ({required force}) => _research.technicals(symbol, force: force),
    onChanged: notifyListeners,
  );

  late final portfolio = Loadable<PortfolioSnapshot>(
    fetch: _portfolio.snapshot,
    peek: _portfolio.cachedSnapshot,
    onChanged: notifyListeners,
  );

  late final prediction = Loadable<Prediction>(
    fetch: ({required force}) => _research.prediction(symbol, force: force),
    onChanged: notifyListeners,
  );

  late final fundamentals = Loadable<Fundamentals>(
    fetch: ({required force}) => _research.fundamentals(symbol, force: force),
    onChanged: notifyListeners,
  );

  late final glossary = Loadable<Glossary>(
    fetch: ({required force}) => _research.glossary(),
    peek: _research.cachedGlossary,
    onChanged: notifyListeners,
  );

  late final summary = Loadable<AiSummary>(
    fetch: ({required force}) => _research.summary(symbol, regenerate: force),
    onChanged: notifyListeners,
  );

  ChartRange _range = ChartRange.quarter;
  bool _candles = false;

  ChartRange get range => _range;

  /// Candles rather than a line. A line reads better on a phone over long
  /// ranges, so it is the default.
  bool get showCandles => _candles;

  /// This stock in the user's demat account, if they hold it.
  Holding? get holding => portfolio.data?.holdings.firstWhereOrNull((h) => h.symbol == symbol);

  /// The holding's share of the portfolio's current value, 0–1.
  double? get portfolioWeight {
    final h = holding;
    final total = portfolio.data?.summary.currentValue;
    if (h == null || total == null || total <= 0) return null;
    return h.currentValue / total;
  }

  /// The broker's last price when held (fresher), else the last close.
  double? get lastPrice => holding?.lastPrice ?? technicals.data?.currentPrice;

  PriceChange? get dayMove {
    final history = technicals.data?.history;
    final ltp = lastPrice;
    if (history == null || ltp == null) return null;
    return dayChange(history, ltp: ltp);
  }

  /// When Regenerate will produce new text, or null when it would now.
  DateTime? get regenerateAvailableAt {
    final s = summary.data;
    // Served from the server's cache: when it was written is unknown, and
    // likely long ago, so a regenerate is allowed.
    if (s == null || s.cached) return null;
    final at = s.receivedAt.add(regenerateCooldown);
    return at.isAfter(_now()) ? at : null;
  }

  Future<void> load() => Future.wait([technicals.load(), portfolio.load()]);

  /// Pull-to-refresh: everything already asked for, fresh, including a
  /// section that failed (say Yahoo was down). Never a good AI summary,
  /// which costs money and does not change with prices; a failed one is
  /// retried, since a failure cost nothing.
  Future<void> refresh() => Future.wait([
    technicals.load(force: true),
    portfolio.load(force: true),
    if (prediction.state is! ViewIdle) prediction.load(force: true),
    if (fundamentals.state is! ViewIdle) fundamentals.load(force: true),
    if (summary.state is ViewError) summary.load(),
  ]);

  void onTabShown(StockTab tab) {
    switch (tab) {
      case StockTab.overview || StockTab.technicals:
        break;
      case StockTab.fundamentals:
        unawaited(fundamentals.ensureLoaded());
        unawaited(glossary.ensureLoaded());
      case StockTab.ai:
        unawaited(summary.ensureLoaded());
    }
  }

  /// The prediction card scrolled into view.
  Future<void> revealPrediction() => prediction.ensureLoaded();

  Future<void> regenerateSummary() async {
    if (regenerateAvailableAt != null) return;
    await summary.load(force: true);
  }

  void setRange(ChartRange range) {
    if (range == _range) return;
    _range = range;
    notifyListeners();
  }

  void setCandles({required bool candles}) {
    if (candles == _candles) return;
    _candles = candles;
    notifyListeners();
  }
}
