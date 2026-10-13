// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markets_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorNewsDto _$SectorNewsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SectorNewsDto', json, ($checkedConvert) {
      final val = SectorNewsDto(
        name: $checkedConvert('name', (v) => jsonString(v)),
        invested: $checkedConvert('invested', (v) => jsonNum(v)),
        news: $checkedConvert(
          'news',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        sentimentSummary: $checkedConvert(
          'sentiment_summary',
          (v) => v == null ? null : SummaryDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'sentimentSummary': 'sentiment_summary'});

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ArticleDto', json, ($checkedConvert) {
      final val = ArticleDto(
        title: $checkedConvert('title', (v) => jsonString(v)),
        link: $checkedConvert('link', (v) => jsonString(v)),
        date: $checkedConvert('date', (v) => jsonString(v)),
        description: $checkedConvert('description', (v) => jsonString(v)),
        source: $checkedConvert('source', (v) => jsonString(v)),
        sentiment: $checkedConvert(
          'sentiment',
          (v) => v == null ? null : ToneDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

ToneDto _$ToneDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ToneDto', json, ($checkedConvert) {
      final val = ToneDto(
        label: $checkedConvert(
          'label',
          (v) =>
              $enumDecodeNullable(_$ArticleToneEnumMap, v, unknownValue: ArticleTone.neutral) ??
              ArticleTone.neutral,
        ),
        confidence: $checkedConvert('confidence', (v) => jsonNum(v)),
      );
      return val;
    });

const _$ArticleToneEnumMap = {
  ArticleTone.positive: 'positive',
  ArticleTone.negative: 'negative',
  ArticleTone.neutral: 'neutral',
};

SummaryDto _$SummaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SummaryDto', json, ($checkedConvert) {
      final val = SummaryDto(
        label: $checkedConvert(
          'label',
          (v) => $enumDecodeNullable(_$MoodEnumMap, v, unknownValue: Mood.neutral) ?? Mood.neutral,
        ),
        bullish: $checkedConvert('bullish', (v) => jsonInt(v)),
        bearish: $checkedConvert('bearish', (v) => jsonInt(v)),
        neutral: $checkedConvert('neutral', (v) => jsonInt(v)),
        avgScore: $checkedConvert('avg_score', (v) => jsonNumOrNull(v)),
        score: $checkedConvert('score', (v) => jsonNumOrNull(v)),
      );
      return val;
    }, fieldKeyMap: const {'avgScore': 'avg_score'});

const _$MoodEnumMap = {Mood.bullish: 'bullish', Mood.bearish: 'bearish', Mood.neutral: 'neutral'};

SentimentDto _$SentimentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SentimentDto', json, ($checkedConvert) {
      final val = SentimentDto(
        sectors: $checkedConvert(
          'sectors',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => SectorNewsDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        portfolioSentiment: $checkedConvert(
          'portfolio_sentiment',
          (v) => SummaryDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'portfolioSentiment': 'portfolio_sentiment'});

BreadthDto _$BreadthDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'BreadthDto',
  json,
  ($checkedConvert) {
    final val = BreadthDto(
      sectorHeatmap: $checkedConvert(
        'sector_heatmap',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => IndexMoveDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
      indiaVix: $checkedConvert(
        'india_vix',
        (v) => v == null ? null : VixDto.fromJson(v as Map<String, dynamic>),
      ),
      week52Highs: $checkedConvert('week52_highs', (v) => _intOrNull(v)),
      week52Lows: $checkedConvert('week52_lows', (v) => _intOrNull(v)),
      advanceDecline: $checkedConvert(
        'advance_decline',
        (v) => v == null ? null : AdvanceDeclineDto.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'sectorHeatmap': 'sector_heatmap',
    'indiaVix': 'india_vix',
    'week52Highs': 'week52_highs',
    'week52Lows': 'week52_lows',
    'advanceDecline': 'advance_decline',
  },
);

IndexMoveDto _$IndexMoveDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('IndexMoveDto', json, ($checkedConvert) {
      final val = IndexMoveDto(
        name: $checkedConvert('name', (v) => jsonString(v)),
        change: $checkedConvert('change', (v) => jsonNum(v)),
      );
      return val;
    });

VixDto _$VixDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VixDto', json, ($checkedConvert) {
      final val = VixDto(
        current: $checkedConvert('current', (v) => jsonNumOrNull(v)),
        change: $checkedConvert('change', (v) => jsonNumOrNull(v)),
      );
      return val;
    });

AdvanceDeclineDto _$AdvanceDeclineDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdvanceDeclineDto', json, ($checkedConvert) {
      final val = AdvanceDeclineDto(
        advances: $checkedConvert('advances', (v) => _intOrNull(v)),
        declines: $checkedConvert('declines', (v) => _intOrNull(v)),
      );
      return val;
    });

SectorExposureDto _$SectorExposureDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'SectorExposureDto',
  json,
  ($checkedConvert) {
    final val = SectorExposureDto(
      name: $checkedConvert('name', (v) => jsonString(v)),
      weight: $checkedConvert('weight', (v) => jsonNum(v)),
      invested: $checkedConvert('invested', (v) => jsonNum(v)),
      holdingsCount: $checkedConvert('holdings_count', (v) => jsonInt(v)),
      holdings: $checkedConvert(
        'holdings',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => SectorHoldingDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
      driver: $checkedConvert('driver', (v) => jsonString(v)),
      indexName: $checkedConvert('index_name', (v) => jsonStringOrNull(v)),
      indexPerformance: $checkedConvert('index_performance', (v) => _indexReturns(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'holdingsCount': 'holdings_count',
    'indexName': 'index_name',
    'indexPerformance': 'index_performance',
  },
);

SectorHoldingDto _$SectorHoldingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SectorHoldingDto', json, ($checkedConvert) {
      final val = SectorHoldingDto(
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        ltp: $checkedConvert('ltp', (v) => jsonNum(v)),
        pnlPct: $checkedConvert('pnl_pct', (v) => jsonNum(v)),
      );
      return val;
    }, fieldKeyMap: const {'pnlPct': 'pnl_pct'});
