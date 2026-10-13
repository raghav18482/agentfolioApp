import 'package:freezed_annotation/freezed_annotation.dart';

part 'markets.freezed.dart';

/// How far back news goes. The server accepts these windows.
enum NewsPeriod {
  day('1d'),
  week('7d'),
  month('1m'),
  quarter('3m');

  NewsPeriod(this.wire);

  final String wire;
}

/// FinBERT's reading of one article.
enum ArticleTone { positive, negative, neutral }

/// The mood across many articles: more positive than negative by a margin,
/// the reverse, or neither.
enum Mood { bullish, bearish, neutral }

@freezed
abstract class ArticleSentiment with _$ArticleSentiment {
  const factory ArticleSentiment({required ArticleTone tone, required double confidence}) =
      _ArticleSentiment;
}

/// A headline from Google News.
@freezed
abstract class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required String title,
    required String description,
    required String source,

    /// The publisher's page, through Google News. Null when not a web link.
    Uri? link,

    /// Parsed from [rawDate] when it is a standard date.
    DateTime? publishedAt,

    /// The date exactly as the server sent it, kept so sentiment requests
    /// echo the article back unchanged.
    @Default('') String rawDate,
    ArticleSentiment? sentiment,
  }) = _NewsArticle;
}

/// Tallies of article tones, and the mood they add up to.
@freezed
abstract class SentimentSummary with _$SentimentSummary {
  const factory SentimentSummary({
    required Mood mood,

    /// -1 (all negative) to 1 (all positive).
    required double score,
    required int bullish,
    required int bearish,
    required int neutral,
  }) = _SentimentSummary;

  const SentimentSummary._();

  int get total => bullish + bearish + neutral;
}

/// News for one sector the user holds.
@freezed
abstract class SectorNews with _$SectorNews {
  const factory SectorNews({
    required String name,

    /// Rupees invested in this sector.
    required double invested,
    required List<NewsArticle> articles,
    SentimentSummary? sentiment,
  }) = _SectorNews;
}

/// `GET /api/news/portfolio`: headlines for the user's biggest sectors.
@freezed
abstract class PortfolioNews with _$PortfolioNews {
  const factory PortfolioNews({required NewsPeriod period, required List<SectorNews> sectors}) =
      _PortfolioNews;

  const PortfolioNews._();

  int get articleCount => sectors.fold(0, (sum, s) => sum + s.articles.length);
}

/// `POST /api/news/sentiment`: the same news with a tone per article, a mood
/// per sector, and the portfolio's overall mood.
@freezed
abstract class NewsSentiment with _$NewsSentiment {
  const factory NewsSentiment({
    required List<SectorNews> sectors,
    required SentimentSummary overall,
  }) = _NewsSentiment;
}

/// One NSE index's move today.
@freezed
abstract class IndexMove with _$IndexMove {
  const factory IndexMove({required String name, required double changePercent}) = _IndexMove;
}

/// `GET /api/sectors/breadth`: how the whole market is doing. Each part is
/// null when NSE did not answer for it.
@freezed
abstract class MarketBreadth with _$MarketBreadth {
  const factory MarketBreadth({
    required List<IndexMove> indices,
    double? vix,

    /// Points, from NSE's daily VIX history: can lag a session.
    double? vixChange,

    /// Percent, from the live market watch: today's move.
    double? vixChangePercent,
    int? week52Highs,
    int? week52Lows,
    int? advances,
    int? declines,
  }) = _MarketBreadth;
}

/// A sector index's return over standard windows, in percent.
@freezed
abstract class IndexReturns with _$IndexReturns {
  const factory IndexReturns({
    double? level,
    double? week,
    double? month,
    double? quarter,
    double? halfYear,
    double? year,
  }) = _IndexReturns;
}

@freezed
abstract class SectorHolding with _$SectorHolding {
  const factory SectorHolding({
    required String symbol,
    required double lastPrice,
    required double pnlPercent,
  }) = _SectorHolding;
}

/// One sector of the user's portfolio, against its NSE index.
@freezed
abstract class SectorExposure with _$SectorExposure {
  const factory SectorExposure({
    required String name,

    /// Percent of the portfolio's current value.
    required double weight,
    required double invested,
    required int holdingsCount,

    /// The largest few holdings in the sector.
    required List<SectorHolding> holdings,

    /// What moves this sector, in a sentence.
    required String driver,
    String? indexName,
    IndexReturns? indexReturns,
  }) = _SectorExposure;
}
