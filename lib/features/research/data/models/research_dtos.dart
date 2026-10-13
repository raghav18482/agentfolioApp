import 'dart:math' as math;

import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research_dtos.g.dart';

// ── Fundamentals ────────────────────────────────────────────────────────────

/// `GET /api/research/fundamental`.
@JsonSerializable()
class FundamentalsDto {
  const FundamentalsDto({
    required this.symbol,
    required this.revenueTrend,
    required this.profitTrend,
    this.valuation,
    this.health,
    this.score,
    this.sector,
    this.industry,
  });

  factory FundamentalsDto.fromJson(Map<String, dynamic> json) => _$FundamentalsDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  // Empty objects, or absent, when Yahoo had nothing.
  final ValuationDto? valuation;
  final HealthDto? health;
  @JsonKey(defaultValue: <TrendPointDto>[])
  final List<TrendPointDto> revenueTrend;
  @JsonKey(defaultValue: <TrendPointDto>[])
  final List<TrendPointDto> profitTrend;
  final ScoreDto? score;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? sector;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? industry;

  Fundamentals toEntity() => Fundamentals(
    symbol: symbol,
    valuation: (valuation ?? const ValuationDto()).toEntity(),
    health: (health ?? const HealthDto()).toEntity(),
    revenueTrend: [for (final p in revenueTrend) p.toEntity()],
    profitTrend: [for (final p in profitTrend) p.toEntity()],
    score: score?.toEntity(),
    sector: sector,
    industry: industry,
  );
}

@JsonSerializable()
class ValuationDto {
  const ValuationDto({
    this.peRatio,
    this.forwardPe,
    this.pbRatio,
    this.evEbitda,
    this.pegRatio,
    this.dividendYield,
    this.trailingEps,
  });

  factory ValuationDto.fromJson(Map<String, dynamic> json) => _$ValuationDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? peRatio;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? forwardPe;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? pbRatio;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? evEbitda;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? pegRatio;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? dividendYield;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? trailingEps;

  Valuation toEntity() => Valuation(
    peRatio: peRatio,
    forwardPe: forwardPe,
    pbRatio: pbRatio,
    evEbitda: evEbitda,
    pegRatio: pegRatio,
    dividendYield: dividendYield,
    trailingEps: trailingEps,
  );
}

@JsonSerializable()
class HealthDto {
  const HealthDto({
    this.roe,
    this.roce,
    this.debtToEquity,
    this.freeCashFlow,
    this.profitMargin,
    this.operatingMargin,
    this.revenueGrowth,
    this.earningsGrowth,
    this.promoterHolding,
  });

  factory HealthDto.fromJson(Map<String, dynamic> json) => _$HealthDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? roe;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? roce;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? debtToEquity;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? freeCashFlow;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? profitMargin;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? operatingMargin;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? revenueGrowth;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? earningsGrowth;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? promoterHolding;

  FinancialHealth toEntity() => FinancialHealth(
    roe: roe,
    roce: roce,
    debtToEquity: debtToEquity,
    freeCashFlow: freeCashFlow,
    profitMargin: profitMargin,
    operatingMargin: operatingMargin,
    revenueGrowth: revenueGrowth,
    earningsGrowth: earningsGrowth,
    promoterHolding: promoterHolding,
  );
}

@JsonSerializable()
class TrendPointDto {
  const TrendPointDto({required this.year, required this.value});

  factory TrendPointDto.fromJson(Map<String, dynamic> json) => _$TrendPointDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String year;
  @JsonKey(fromJson: jsonNum)
  final double value;

  TrendPoint toEntity() => TrendPoint(year: year, value: value);
}

@JsonSerializable()
class ScoreDto {
  const ScoreDto({
    required this.label,
    required this.confidence,
    required this.metricsUsed,
    required this.metricsTotal,
    required this.pillars,
    required this.strengths,
    required this.concerns,
    required this.excluded,
    this.total,
    this.grade,
    this.note,
  });

  factory ScoreDto.fromJson(Map<String, dynamic> json) => _$ScoreDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? total;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? grade;
  @JsonKey(fromJson: jsonString)
  final String label;
  @JsonKey(unknownEnumValue: ScoreConfidence.none, defaultValue: ScoreConfidence.none)
  final ScoreConfidence confidence;
  @JsonKey(fromJson: jsonInt)
  final int metricsUsed;
  @JsonKey(fromJson: jsonInt)
  final int metricsTotal;
  @JsonKey(defaultValue: <PillarDto>[])
  final List<PillarDto> pillars;
  @JsonKey(fromJson: jsonStringList)
  final List<String> strengths;
  @JsonKey(fromJson: jsonStringList)
  final List<String> concerns;
  @JsonKey(fromJson: jsonStringList)
  final List<String> excluded;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? note;

  FundamentalScore toEntity() => FundamentalScore(
    total: total,
    grade: grade,
    label: label,
    confidence: confidence,
    metricsUsed: metricsUsed,
    metricsTotal: metricsTotal,
    pillars: [for (final p in pillars) p.toEntity()],
    strengths: strengths,
    concerns: concerns,
    excluded: excluded,
    note: note,
  );
}

@JsonSerializable()
class PillarDto {
  const PillarDto({
    required this.key,
    required this.label,
    required this.tagline,
    required this.max,
    required this.metrics,
    this.score,
  });

  factory PillarDto.fromJson(Map<String, dynamic> json) => _$PillarDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String key;
  @JsonKey(fromJson: jsonString)
  final String label;
  @JsonKey(fromJson: jsonString)
  final String tagline;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? score;
  @JsonKey(fromJson: jsonNum)
  final double max;
  @JsonKey(defaultValue: <ScoreMetricDto>[])
  final List<ScoreMetricDto> metrics;

  ScorePillar toEntity() => ScorePillar(
    key: key,
    label: label,
    tagline: tagline,
    score: score,
    max: max,
    metrics: [for (final m in metrics) m.toEntity()],
  );
}

@JsonSerializable()
class ScoreMetricDto {
  const ScoreMetricDto({
    required this.key,
    required this.label,
    required this.display,
    required this.verdict,
    required this.note,
    this.value,
  });

  factory ScoreMetricDto.fromJson(Map<String, dynamic> json) => _$ScoreMetricDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String key;
  @JsonKey(fromJson: jsonString)
  final String label;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? value;
  @JsonKey(fromJson: jsonString)
  final String display;
  @JsonKey(unknownEnumValue: Verdict.unknown, defaultValue: Verdict.unknown)
  final Verdict verdict;
  @JsonKey(fromJson: jsonString)
  final String note;

  ScoreMetric toEntity() => ScoreMetric(
    key: key,
    label: label,
    value: value,
    display: display,
    verdict: verdict,
    note: note,
  );
}

/// `POST /api/research/fundamental/summary`.
@JsonSerializable()
class SummaryDto {
  const SummaryDto({required this.summary, required this.cached});

  factory SummaryDto.fromJson(Map<String, dynamic> json) => _$SummaryDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String summary;
  @JsonKey(defaultValue: false)
  final bool cached;

  AiSummary toEntity(DateTime receivedAt) =>
      AiSummary(markdown: summary.trim(), cached: cached, receivedAt: receivedAt);
}

// ── Technicals ──────────────────────────────────────────────────────────────

/// `GET /api/research/technical`.
@JsonSerializable()
class TechnicalsDto {
  const TechnicalsDto({
    required this.symbol,
    required this.currentPrice,
    required this.signals,
    this.indicators,
    this.supportResistance,
    this.chartData,
  });

  factory TechnicalsDto.fromJson(Map<String, dynamic> json) => _$TechnicalsDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonNum)
  final double currentPrice;
  final IndicatorsDto? indicators;
  @JsonKey(defaultValue: <SignalDto>[])
  final List<SignalDto> signals;
  final LevelsDto? supportResistance;
  final ChartDataDto? chartData;

  Technicals toEntity() => Technicals(
    symbol: symbol,
    currentPrice: currentPrice,
    indicators: (indicators ?? const IndicatorsDto()).toEntity(),
    signals: [for (final s in signals) s.toEntity()],
    levels: (supportResistance ?? const LevelsDto()).toEntity(),
    history: chartData?.toEntity() ?? PriceHistory.empty,
  );
}

@JsonSerializable()
class IndicatorsDto {
  const IndicatorsDto({
    this.sma20,
    this.sma50,
    this.sma200,
    this.rsi,
    this.macd,
    this.macdSignal,
    this.macdHistogram,
    this.week52High,
    this.week52Low,
    this.week52Position,
    this.volumeRatio,
  });

  factory IndicatorsDto.fromJson(Map<String, dynamic> json) => _$IndicatorsDtoFromJson(json);

  @JsonKey(name: 'sma_20', fromJson: jsonNumOrNull)
  final double? sma20;
  @JsonKey(name: 'sma_50', fromJson: jsonNumOrNull)
  final double? sma50;
  @JsonKey(name: 'sma_200', fromJson: jsonNumOrNull)
  final double? sma200;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? rsi;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? macd;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? macdSignal;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? macdHistogram;
  @JsonKey(name: 'week52_high', fromJson: jsonNumOrNull)
  final double? week52High;
  @JsonKey(name: 'week52_low', fromJson: jsonNumOrNull)
  final double? week52Low;
  @JsonKey(name: 'week52_position', fromJson: jsonNumOrNull)
  final double? week52Position;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? volumeRatio;

  TechnicalIndicators toEntity() => TechnicalIndicators(
    sma20: sma20,
    sma50: sma50,
    sma200: sma200,
    rsi: rsi,
    macd: macd,
    macdSignal: macdSignal,
    macdHistogram: macdHistogram,
    week52High: week52High,
    week52Low: week52Low,
    week52Position: week52Position,
    volumeRatio: volumeRatio,
  );
}

@JsonSerializable()
class SignalDto {
  const SignalDto({
    required this.name,
    required this.status,
    required this.value,
    required this.label,
  });

  factory SignalDto.fromJson(Map<String, dynamic> json) => _$SignalDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String name;
  @JsonKey(unknownEnumValue: SignalStatus.neutral, defaultValue: SignalStatus.neutral)
  final SignalStatus status;
  @JsonKey(fromJson: jsonString)
  final String value;
  @JsonKey(fromJson: jsonString)
  final String label;

  TechnicalSignal toEntity() =>
      TechnicalSignal(name: name, status: status, value: value, label: label);
}

@JsonSerializable()
class LevelsDto {
  const LevelsDto({this.pivot, this.r1, this.r2, this.s1, this.s2});

  factory LevelsDto.fromJson(Map<String, dynamic> json) => _$LevelsDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? pivot;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? r1;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? r2;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? s1;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? s2;

  PivotLevels toEntity() => PivotLevels(pivot: pivot, r1: r1, r2: r2, s1: s1, s2: s2);
}

/// Chart arrays. `ohlc` rows are `[open, high, low, close]`: not the
/// candles endpoint's `[time, open, high, low, close, volume]`, and not
/// ECharts' order either. Reading the wrong order draws every candle with the
/// day's high as its close, the bug the web app once shipped.
@JsonSerializable()
class ChartDataDto {
  const ChartDataDto({
    required this.dates,
    required this.ohlc,
    required this.volume,
    required this.sma50,
    required this.sma200,
    required this.rsi,
    required this.macdLine,
    required this.macdSignal,
    required this.macdHistogram,
  });

  factory ChartDataDto.fromJson(Map<String, dynamic> json) => _$ChartDataDtoFromJson(json);

  @JsonKey(fromJson: jsonStringList)
  final List<String> dates;
  @JsonKey(fromJson: _ohlcRows)
  final List<Ohlc?> ohlc;
  @JsonKey(fromJson: jsonNumOrNullList)
  final List<double?> volume;
  @JsonKey(name: 'sma_50', fromJson: jsonNumOrNullList)
  final List<double?> sma50;
  @JsonKey(name: 'sma_200', fromJson: jsonNumOrNullList)
  final List<double?> sma200;
  @JsonKey(fromJson: jsonNumOrNullList)
  final List<double?> rsi;
  @JsonKey(fromJson: jsonNumOrNullList)
  final List<double?> macdLine;
  @JsonKey(fromJson: jsonNumOrNullList)
  final List<double?> macdSignal;
  @JsonKey(fromJson: jsonNumOrNullList)
  final List<double?> macdHistogram;

  PriceHistory toEntity() {
    // Keep only days with both a readable date and a full bar.
    final days = <int>[
      for (var i = 0; i < math.min(dates.length, ohlc.length); i++)
        if (DateTime.tryParse(dates[i]) != null && ohlc[i] != null) i,
    ];
    final n = math.min(dates.length, ohlc.length);
    List<double?> aligned(List<double?> series) {
      final full = alignToEnd(series, n);
      return [for (final i in days) full[i]];
    }

    return PriceHistory(
      dates: [for (final i in days) DateTime.parse(dates[i])],
      bars: [for (final i in days) ohlc[i]!],
      volumes: [for (final v in aligned(volume)) v ?? 0],
      sma50: aligned(sma50),
      sma200: aligned(sma200),
      rsi: aligned(rsi),
      macd: aligned(macdLine),
      macdSignal: aligned(macdSignal),
      macdHistogram: aligned(macdHistogram),
    );
  }
}

/// Fits [series] to [length] entries ending on the last date. The server
/// sends an empty list, not nulls, for an indicator whose window is longer
/// than the history (SMA 200 on a stock listed eight months ago).
List<double?> alignToEnd(List<double?> series, int length) {
  if (series.length >= length) return series.sublist(series.length - length);
  return [...List<double?>.filled(length - series.length, null), ...series];
}

List<Ohlc?> _ohlcRows(Object? json) => json is List
    ? [
        for (final row in json)
          if (row is List && row.length >= 4) _ohlc(row) else null,
      ]
    : const [];

Ohlc? _ohlc(List<dynamic> row) {
  final open = jsonNumOrNull(row[0]);
  final high = jsonNumOrNull(row[1]);
  final low = jsonNumOrNull(row[2]);
  final close = jsonNumOrNull(row[3]);
  if (open == null || high == null || low == null || close == null) return null;
  return Ohlc(open: open, high: high, low: low, close: close);
}

// ── Prediction ──────────────────────────────────────────────────────────────

/// `GET /api/portfolio/predict`.
@JsonSerializable()
class PredictionDto {
  const PredictionDto({
    required this.symbol,
    required this.predictions,
    required this.overallOutlook,
    required this.overallScore,
    required this.modelType,
    required this.topBullishSignals,
    required this.topBearishSignals,
    this.modelVersion,
    this.calibrated,
    this.disclaimer,
  });

  factory PredictionDto.fromJson(Map<String, dynamic> json) => _$PredictionDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(defaultValue: <String, HorizonDto>{})
  final Map<String, HorizonDto> predictions;
  @JsonKey(unknownEnumValue: Outlook.neutral, defaultValue: Outlook.neutral)
  final Outlook overallOutlook;
  @JsonKey(fromJson: jsonNum)
  final double overallScore;
  @JsonKey(fromJson: jsonString)
  final String modelType;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? modelVersion;
  final bool? calibrated;
  @JsonKey(fromJson: jsonStringOrNull)
  final String? disclaimer;
  @JsonKey(defaultValue: <PredictionSignalDto>[])
  final List<PredictionSignalDto> topBullishSignals;
  @JsonKey(defaultValue: <PredictionSignalDto>[])
  final List<PredictionSignalDto> topBearishSignals;

  Prediction toEntity() => Prediction(
    symbol: symbol,
    // Horizons the app does not know are dropped, not guessed at.
    calls: {
      for (final h in Horizon.values)
        if (predictions[h.wire] case final call?) h: call.toEntity(),
    },
    outlook: overallOutlook,
    overallScore: overallScore,
    modelType: modelType,
    modelVersion: modelVersion,
    calibrated: calibrated,
    disclaimer: disclaimer,
    bullishSignals: [for (final s in topBullishSignals) s.toEntity()],
    bearishSignals: [for (final s in topBearishSignals) s.toEntity()],
  );
}

@JsonSerializable()
class HorizonDto {
  const HorizonDto({
    required this.direction,
    required this.confidence,
    required this.score,
    this.probabilityUp,
    this.calibrated,
  });

  factory HorizonDto.fromJson(Map<String, dynamic> json) => _$HorizonDtoFromJson(json);

  @JsonKey(unknownEnumValue: Direction.neutral, defaultValue: Direction.neutral)
  final Direction direction;
  @JsonKey(fromJson: jsonNum)
  final double confidence;
  @JsonKey(fromJson: jsonNum)
  final double score;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? probabilityUp;
  final bool? calibrated;

  HorizonCall toEntity() => HorizonCall(
    direction: direction,
    confidence: confidence.clamp(0, 1),
    score: score,
    probabilityUp: probabilityUp,
    calibrated: calibrated,
  );
}

@JsonSerializable()
class PredictionSignalDto {
  const PredictionSignalDto({required this.feature, this.value});

  factory PredictionSignalDto.fromJson(Map<String, dynamic> json) =>
      _$PredictionSignalDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String feature;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? value;

  PredictionSignal toEntity() => PredictionSignal(feature: feature, value: value);
}

// ── Glossary ────────────────────────────────────────────────────────────────

/// `static/data/metric_glossary.json`.
@JsonSerializable()
class GlossaryDto {
  const GlossaryDto({
    required this.intro,
    required this.pillars,
    required this.metrics,
    required this.scoring,
  });

  factory GlossaryDto.fromJson(Map<String, dynamic> json) => _$GlossaryDtoFromJson(json);

  @JsonKey(defaultValue: <GlossaryIntroDto>[])
  final List<GlossaryIntroDto> intro;

  /// JSON object order is kept: it is the order the guide presents them.
  @JsonKey(defaultValue: <String, GlossaryPillarDto>{})
  final Map<String, GlossaryPillarDto> pillars;
  @JsonKey(defaultValue: <String, GlossaryMetricDto>{})
  final Map<String, GlossaryMetricDto> metrics;
  final GlossaryScoringDto scoring;

  Glossary toEntity() => Glossary(
    intro: [for (final i in intro) GlossaryIntro(title: i.title, body: i.body)],
    pillars: [
      for (final MapEntry(:key, :value) in pillars.entries)
        GlossaryPillar(key: key, label: value.label, tagline: value.tagline, body: value.body),
    ],
    metrics: {for (final MapEntry(:key, :value) in metrics.entries) key: value.toEntity(key)},
    scoring: ScoringGuide(
      grades: [
        for (final g in scoring.grades) GradeBand(min: g.min, grade: g.grade, label: g.label),
      ],
      howItWorks: scoring.howItWorks,
      limits: scoring.limits,
    ),
  );
}

@JsonSerializable()
class GlossaryIntroDto {
  const GlossaryIntroDto({required this.title, required this.body});

  factory GlossaryIntroDto.fromJson(Map<String, dynamic> json) => _$GlossaryIntroDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String title;
  @JsonKey(fromJson: jsonString)
  final String body;
}

@JsonSerializable()
class GlossaryPillarDto {
  const GlossaryPillarDto({required this.label, required this.tagline, required this.body});

  factory GlossaryPillarDto.fromJson(Map<String, dynamic> json) =>
      _$GlossaryPillarDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String label;
  @JsonKey(fromJson: jsonString)
  final String tagline;
  @JsonKey(fromJson: jsonString)
  final String body;
}

@JsonSerializable()
class GlossaryMetricDto {
  const GlossaryMetricDto({
    required this.label,
    required this.fullName,
    required this.pillar,
    required this.weight,
    required this.formula,
    required this.plain,
    required this.ideal,
    required this.bands,
    required this.caveat,
    required this.watchOut,
  });

  factory GlossaryMetricDto.fromJson(Map<String, dynamic> json) =>
      _$GlossaryMetricDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String label;
  @JsonKey(fromJson: jsonString)
  final String fullName;
  @JsonKey(fromJson: jsonString)
  final String pillar;
  @JsonKey(fromJson: jsonNum)
  final double weight;
  @JsonKey(fromJson: jsonString)
  final String formula;
  @JsonKey(fromJson: jsonString)
  final String plain;
  @JsonKey(fromJson: jsonString)
  final String ideal;
  @JsonKey(defaultValue: <GlossaryBandDto>[])
  final List<GlossaryBandDto> bands;
  @JsonKey(fromJson: jsonString)
  final String caveat;
  @JsonKey(fromJson: jsonString)
  final String watchOut;

  GlossaryMetric toEntity(String key) => GlossaryMetric(
    key: key,
    label: label,
    fullName: fullName,
    pillar: pillar,
    weight: weight,
    formula: formula,
    plain: plain,
    ideal: ideal,
    bands: [for (final b in bands) GlossaryBand(max: b.max, verdict: b.verdict, note: b.note)],
    caveat: caveat,
    watchOut: watchOut,
  );
}

@JsonSerializable()
class GlossaryBandDto {
  const GlossaryBandDto({required this.verdict, required this.note, this.max});

  factory GlossaryBandDto.fromJson(Map<String, dynamic> json) => _$GlossaryBandDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? max;
  @JsonKey(unknownEnumValue: Verdict.unknown, defaultValue: Verdict.unknown)
  final Verdict verdict;
  @JsonKey(fromJson: jsonString)
  final String note;
}

@JsonSerializable()
class GlossaryScoringDto {
  const GlossaryScoringDto({required this.grades, required this.howItWorks, required this.limits});

  factory GlossaryScoringDto.fromJson(Map<String, dynamic> json) =>
      _$GlossaryScoringDtoFromJson(json);

  @JsonKey(defaultValue: <GradeBandDto>[])
  final List<GradeBandDto> grades;
  @JsonKey(fromJson: jsonStringList)
  final List<String> howItWorks;
  @JsonKey(fromJson: jsonString)
  final String limits;
}

@JsonSerializable()
class GradeBandDto {
  const GradeBandDto({required this.min, required this.grade, required this.label});

  factory GradeBandDto.fromJson(Map<String, dynamic> json) => _$GradeBandDtoFromJson(json);

  @JsonKey(fromJson: jsonNum)
  final double min;
  @JsonKey(fromJson: jsonString)
  final String grade;
  @JsonKey(fromJson: jsonString)
  final String label;
}
