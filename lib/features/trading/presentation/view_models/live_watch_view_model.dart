import 'dart:async';

import 'package:agentfolio/core/market/market_stream.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/repositories/research_repository.dart';

/// One stock watched live: its recent history for context, and the price as
/// it ticks. Watches only while on screen, so a hidden tab holds no stream.
class LiveWatchViewModel extends BaseViewModel {
  LiveWatchViewModel({
    required this._portfolio,
    required this._research,
    required this._stream,
    required super.telemetry,
  });

  final PortfolioRepository _portfolio;
  final ResearchRepository _research;
  final MarketStream _stream;

  late final holdings = Loadable<List<Holding>>(
    fetch: ({required force}) async => (await _portfolio.snapshot(force: force)).map(_byValue),
    peek: () => _portfolio.cachedSnapshot()?.let(_byValue),
    onChanged: _onHoldings,
  );

  Loadable<Technicals>? _history;
  Loadable<Technicals>? get history => _history;

  String? _symbol;
  String? get symbol => _symbol;

  LiveQuote? _quote;
  LiveQuote? get quote => _quote;

  bool _visible = false;

  Holding? get holding => holdings.data?.where((h) => h.symbol == _symbol).firstOrNull;

  static List<Holding> _byValue(PortfolioSnapshot s) =>
      [...s.holdings]..sort((a, b) => b.currentValue.compareTo(a.currentValue));

  Future<void> load() => holdings.load();

  void _onHoldings() {
    // Start on the biggest holding until the user picks another.
    if (_symbol == null) {
      final first = holdings.data?.firstOrNull;
      if (first != null) select(first.symbol);
    }
    notifyListeners();
  }

  /// Watches [raw]: a holding's symbol, or any NSE symbol typed in.
  void select(String raw) {
    final symbol = raw.trim().toUpperCase();
    if (symbol.isEmpty || symbol == _symbol) return;
    _symbol = symbol;
    _history = Loadable<Technicals>(
      fetch: ({required force}) => _research.technicals(symbol, force: force),
      onChanged: notifyListeners,
    );
    unawaited(_history!.load());
    _rewatch();
    notifyListeners();
  }

  void setVisible({required bool visible}) {
    if (_visible == visible) return;
    _visible = visible;
    _rewatch();
    notifyListeners();
  }

  void _rewatch() {
    _quote?.cancel();
    _quote = null;
    final symbol = _symbol;
    if (!_visible || symbol == null) return;
    _quote = _stream.watch(symbol, brokerToken: holding?.brokerToken);
  }

  @override
  void dispose() {
    _quote?.cancel();
    super.dispose();
  }
}

extension<T> on T {
  R let<R>(R Function(T value) f) => f(this);
}
