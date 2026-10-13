import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';

/// News and market-wide data. News comes from Google News through the server;
/// breadth and sector indices from NSE.
abstract interface class MarketsRepository {
  /// Headlines for the sectors the user holds. Slow: one search per sector.
  Future<Result<PortfolioNews>> portfolioNews(NewsPeriod period, {bool force = false});

  /// The tone of each of [news]'s articles, by FinBERT on the server. Heavy,
  /// so only on request, and kept for the session per period.
  Future<Result<NewsSentiment>> sentiment(PortfolioNews news);

  NewsSentiment? cachedSentiment(NewsPeriod period);

  Future<Result<List<NewsArticle>>> search(String query, NewsPeriod period);

  Future<Result<MarketBreadth>> breadth({bool force = false});

  /// The user's sectors against their indices. Empty when there are no holdings.
  Future<Result<List<SectorExposure>>> sectors({bool force = false});
}
