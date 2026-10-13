import 'dart:io' show HttpDate;

import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'markets_dtos.g.dart';

// ── News ────────────────────────────────────────────────────────────────────

/// `GET /api/news/portfolio`, and the `sectors` of `POST /api/news/sentiment`.
@JsonSerializable()
class SectorNewsDto {
  const SectorNewsDto({
    required this.name,
    required this.invested,
    required this.news,
    this.sentimentSummary,
  });

  factory SectorNewsDto.fromJson(Map<String, dynamic> json) => _$SectorNewsDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String name;
  @JsonKey(fromJson: jsonNum)
  final double invested;
  @JsonKey(defaultValue: <ArticleDto>[])
  final List<ArticleDto> news;
  final SummaryDto? sentimentSummary;

  SectorNews toEntity() => SectorNews(
    name: name,
    invested: invested,
    articles: [
      for (final a in news)
        if (a.title.trim().isNotEmpty) a.toEntity(),
    ],
    sentiment: sentimentSummary?.toEntity(),
  );
}

@JsonSerializable()
class ArticleDto {
  const ArticleDto({
    required this.title,
    required this.link,
    required this.date,
    required this.description,
    required this.source,
    this.sentiment,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) => _$ArticleDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String title;
  @JsonKey(fromJson: jsonString)
  final String link;
  @JsonKey(fromJson: jsonString)
  final String date;
  @JsonKey(fromJson: jsonString)
  final String description;
  @JsonKey(fromJson: jsonString)
  final String source;
  final ToneDto? sentiment;

  NewsArticle toEntity() => NewsArticle(
    title: title.trim(),
    description: description.trim(),
    source: source.trim(),
    link: webLink(link),
    publishedAt: parseNewsDate(date),
    rawDate: date,
    sentiment: sentiment?.toEntity(),
  );
}

@JsonSerializable()
class ToneDto {
  const ToneDto({required this.label, required this.confidence});

  factory ToneDto.fromJson(Map<String, dynamic> json) => _$ToneDtoFromJson(json);

  @JsonKey(unknownEnumValue: ArticleTone.neutral, defaultValue: ArticleTone.neutral)
  final ArticleTone label;
  @JsonKey(fromJson: jsonNum)
  final double confidence;

  ArticleSentiment toEntity() => ArticleSentiment(tone: label, confidence: confidence.clamp(0, 1));
}

/// A sector's summary (`avg_score`) or the portfolio's (`score`).
@JsonSerializable()
class SummaryDto {
  const SummaryDto({
    required this.label,
    required this.bullish,
    required this.bearish,
    required this.neutral,
    this.avgScore,
    this.score,
  });

  factory SummaryDto.fromJson(Map<String, dynamic> json) => _$SummaryDtoFromJson(json);

  @JsonKey(unknownEnumValue: Mood.neutral, defaultValue: Mood.neutral)
  final Mood label;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? avgScore;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? score;
  @JsonKey(fromJson: jsonInt)
  final int bullish;
  @JsonKey(fromJson: jsonInt)
  final int bearish;
  @JsonKey(fromJson: jsonInt)
  final int neutral;

  SentimentSummary toEntity() => SentimentSummary(
    mood: label,
    score: (score ?? avgScore ?? 0).clamp(-1, 1),
    bullish: bullish,
    bearish: bearish,
    neutral: neutral,
  );
}

@JsonSerializable()
class SentimentDto {
  const SentimentDto({required this.sectors, required this.portfolioSentiment});

  factory SentimentDto.fromJson(Map<String, dynamic> json) => _$SentimentDtoFromJson(json);

  @JsonKey(defaultValue: <SectorNewsDto>[])
  final List<SectorNewsDto> sectors;
  final SummaryDto portfolioSentiment;

  NewsSentiment toEntity() => NewsSentiment(
    sectors: [for (final s in sectors) s.toEntity()],
    overall: portfolioSentiment.toEntity(),
  );
}

/// The body `POST /api/news/sentiment` expects: the sectors with their
/// articles, exactly as `GET /api/news/portfolio` returned them. (The web app
/// sends only sector names, which the server cannot analyse.)
Map<String, Object?> sentimentRequest(PortfolioNews news) => {
  'sectors': [
    for (final s in news.sectors)
      {
        'name': s.name,
        'invested': s.invested,
        'news': [
          for (final a in s.articles)
            {
              'title': a.title,
              'link': a.link?.toString() ?? '#',
              'date': a.rawDate,
              'description': a.description,
              'source': a.source,
            },
        ],
      },
  ],
};

/// Only http(s) links are opened. gnews sends `#` when it has none.
Uri? webLink(String raw) {
  final uri = Uri.tryParse(raw.trim());
  return uri != null && (uri.isScheme('https') || uri.isScheme('http')) && uri.host.isNotEmpty
      ? uri
      : null;
}

/// gnews dates are RFC 1123 (`Sun, 11 Oct 2026 07:00:00 GMT`); anything else
/// is tried as ISO 8601, then given up on.
DateTime? parseNewsDate(String raw) {
  final s = raw.trim();
  if (s.isEmpty) return null;
  try {
    return HttpDate.parse(s);
  } on Exception {
    // HttpDate throws HttpException for anything not RFC 1123.
    return DateTime.tryParse(s);
  }
}

// ── Sectors and breadth ─────────────────────────────────────────────────────

@JsonSerializable()
class BreadthDto {
  const BreadthDto({
    required this.sectorHeatmap,
    this.indiaVix,
    this.week52Highs,
    this.week52Lows,
    this.advanceDecline,
  });

  factory BreadthDto.fromJson(Map<String, dynamic> json) => _$BreadthDtoFromJson(json);

  @JsonKey(defaultValue: <IndexMoveDto>[])
  final List<IndexMoveDto> sectorHeatmap;
  final VixDto? indiaVix;
  @JsonKey(name: 'week52_highs', fromJson: _intOrNull)
  final int? week52Highs;
  @JsonKey(name: 'week52_lows', fromJson: _intOrNull)
  final int? week52Lows;
  final AdvanceDeclineDto? advanceDecline;

  MarketBreadth toEntity() {
    // India VIX arrives among the indices, but it measures expected
    // volatility, not prices: it is kept out of the movers and its live
    // move goes to the VIX tile instead.
    bool isVix(IndexMoveDto m) => m.name.trim().toUpperCase() == 'INDIA VIX';
    final vixMove = sectorHeatmap.where(isVix).firstOrNull;
    return MarketBreadth(
      indices: [
        for (final m in sectorHeatmap)
          if (m.name.trim().isNotEmpty && !isVix(m))
            IndexMove(name: m.name.trim(), changePercent: m.change),
      ],
      vix: indiaVix?.current,
      vixChange: indiaVix?.change,
      vixChangePercent: vixMove?.change,
      week52Highs: week52Highs,
      week52Lows: week52Lows,
      advances: advanceDecline?.advances,
      declines: advanceDecline?.declines,
    );
  }
}

int? _intOrNull(Object? v) => jsonNumOrNull(v)?.round();

@JsonSerializable()
class IndexMoveDto {
  const IndexMoveDto({required this.name, required this.change});

  factory IndexMoveDto.fromJson(Map<String, dynamic> json) => _$IndexMoveDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String name;
  @JsonKey(fromJson: jsonNum)
  final double change;
}

@JsonSerializable()
class VixDto {
  const VixDto({this.current, this.change});

  factory VixDto.fromJson(Map<String, dynamic> json) => _$VixDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? current;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? change;
}

@JsonSerializable()
class AdvanceDeclineDto {
  const AdvanceDeclineDto({this.advances, this.declines});

  factory AdvanceDeclineDto.fromJson(Map<String, dynamic> json) =>
      _$AdvanceDeclineDtoFromJson(json);

  @JsonKey(fromJson: _intOrNull)
  final int? advances;
  @JsonKey(fromJson: _intOrNull)
  final int? declines;
}

/// One entry of `GET /api/sectors/overview`.
@JsonSerializable()
class SectorExposureDto {
  const SectorExposureDto({
    required this.name,
    required this.weight,
    required this.invested,
    required this.holdingsCount,
    required this.holdings,
    required this.driver,
    this.indexName,
    this.indexPerformance,
  });

  factory SectorExposureDto.fromJson(Map<String, dynamic> json) =>
      _$SectorExposureDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String name;
  @JsonKey(fromJson: jsonNum)
  final double weight;
  @JsonKey(fromJson: jsonNum)
  final double invested;
  @JsonKey(fromJson: jsonInt)
  final int holdingsCount;
  @JsonKey(defaultValue: <SectorHoldingDto>[])
  final List<SectorHoldingDto> holdings;
  @JsonKey(fromJson: jsonString)
  final String driver;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? indexName;
  @JsonKey(fromJson: _indexReturns)
  final IndexReturns? indexPerformance;

  SectorExposure toEntity() => SectorExposure(
    name: name,
    weight: weight,
    invested: invested,
    holdingsCount: holdingsCount,
    holdings: [for (final h in holdings) h.toEntity()],
    driver: driver.trim(),
    // The server says "No index for X" rather than leaving it out.
    indexName: indexName == null || indexName!.startsWith('No index') ? null : indexName,
    indexReturns: indexPerformance,
  );
}

IndexReturns? _indexReturns(Object? json) {
  if (json is! Map) return null;
  double? at(String key) => jsonNumOrNull(json[key]);
  return IndexReturns(
    level: at('current'),
    week: at('1w'),
    month: at('1m'),
    quarter: at('3m'),
    halfYear: at('6m'),
    year: at('1y'),
  );
}

@JsonSerializable()
class SectorHoldingDto {
  const SectorHoldingDto({required this.symbol, required this.ltp, required this.pnlPct});

  factory SectorHoldingDto.fromJson(Map<String, dynamic> json) => _$SectorHoldingDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonNum)
  final double ltp;
  @JsonKey(fromJson: jsonNum)
  final double pnlPct;

  SectorHolding toEntity() => SectorHolding(symbol: symbol, lastPrice: ltp, pnlPercent: pnlPct);
}
