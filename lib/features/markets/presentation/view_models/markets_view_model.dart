import 'dart:async';

import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:agentfolio/features/markets/domain/logic/markets_logic.dart';
import 'package:agentfolio/features/markets/domain/repositories/markets_repository.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

enum MarketsView { news, sectors }

/// Markets: news for the sectors the user holds (with an on-demand
/// sentiment read), news search, and the market's breadth with the user's
/// sectors against their indices.
///
/// Loads what is on screen only: news for the chosen period on open; Sectors
/// the first time that segment is shown; sentiment when asked for.
class MarketsViewModel extends BaseViewModel {
  MarketsViewModel({required this._markets, required this._portfolio, required super.telemetry});

  final MarketsRepository _markets;
  final PortfolioRepository _portfolio;

  MarketsView _view = MarketsView.news;
  NewsPeriod _period = NewsPeriod.week;
  String _query = '';

  MarketsView get view => _view;
  NewsPeriod get period => _period;

  /// The submitted search, or empty when showing portfolio news.
  String get query => _query;
  bool get searching => _query.isNotEmpty;

  // One per period, so switching back to a period already read is instant.
  final _news = <NewsPeriod, Loadable<PortfolioNews>>{};
  final _sentiment = <NewsPeriod, Loadable<NewsSentiment>>{};

  Loadable<PortfolioNews> get news => _news.putIfAbsent(_period, () {
    final period = _period;
    return Loadable(
      fetch: ({required force}) => _markets.portfolioNews(period, force: force),
      onChanged: notifyListeners,
    );
  });

  Loadable<NewsSentiment> get sentiment => _sentiment.putIfAbsent(_period, () {
    final period = _period;
    return Loadable(
      fetch: ({required force}) => _markets.sentiment(_news[period]!.data!),
      peek: () => _markets.cachedSentiment(period),
      onChanged: notifyListeners,
    );
  });

  late final search = Loadable<List<NewsArticle>>(
    fetch: ({required force}) => _markets.search(_query, _period),
    onChanged: notifyListeners,
  );

  late final breadth = Loadable<MarketBreadth>(fetch: _markets.breadth, onChanged: notifyListeners);

  late final sectors = Loadable<List<SectorExposure>>(
    fetch: _markets.sectors,
    onChanged: notifyListeners,
  );

  /// The sectors to list: with tones once sentiment has been read for the
  /// same news, otherwise plain.
  List<SectorNews> get newsSectors {
    final read = sentiment.data;
    return read != null && read.sectors.isNotEmpty
        ? read.sectors
        : (news.data?.sectors ?? const []);
  }

  /// Suggested searches: the user's largest holdings, then market topics.
  List<String> get suggestions {
    final holdings = [...?_portfolio.cachedSnapshot()?.holdings]
      ..sort((a, b) => b.currentValue.compareTo(a.currentValue));
    // Two holdings at most: the largest are often ETFs, weak search terms.
    return searchSuggestions([for (final h in holdings.take(2)) Fmt.symbol(h.symbol)]);
  }

  Future<void> load() => news.load();

  Future<void> refresh() => switch (_view) {
    MarketsView.news when searching => search.load(force: true),
    MarketsView.news => news.load(force: true),
    MarketsView.sectors => Future.wait([breadth.load(force: true), sectors.load(force: true)]),
  };

  void selectView(MarketsView view) {
    if (view == _view) return;
    _view = view;
    notifyListeners();
    if (view == MarketsView.sectors) {
      unawaited(breadth.ensureLoaded());
      unawaited(sectors.ensureLoaded());
    }
  }

  void selectPeriod(NewsPeriod period) {
    if (period == _period) return;
    _period = period;
    notifyListeners();
    unawaited(searching ? search.load() : news.ensureLoaded());
  }

  /// Runs FinBERT over the current news. Heavy, so only on request.
  Future<void> readSentiment() async {
    if (news.data == null || sentiment.isBusy) return;
    await sentiment.load();
  }

  void submitSearch(String text) {
    final q = text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (q.isEmpty || q == _query) return;
    _query = q;
    notifyListeners();
    unawaited(search.load());
  }

  void clearSearch() {
    if (_query.isEmpty) return;
    _query = '';
    notifyListeners();
    unawaited(news.ensureLoaded());
  }
}

extension on Loadable<NewsSentiment> {
  bool get isBusy => state.isBusy;
}
