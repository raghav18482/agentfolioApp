import 'package:freezed_annotation/freezed_annotation.dart';

part 'fundamentals.freezed.dart';

/// How one metric reads against the scorer's fixed bands.
enum Verdict { good, bad, neutral, excluded, unknown }

/// How much of the score rests on real data. [none] goes with an unscorable
/// stock, whose total is null too.
enum ScoreConfidence { high, medium, low, none }

/// Valuation ratios. Each is null when Yahoo had no figure, never zero.
@freezed
abstract class Valuation with _$Valuation {
  const factory Valuation({
    double? peRatio,
    double? forwardPe,
    double? pbRatio,
    double? evEbitda,
    double? pegRatio,

    /// Percent, e.g. 1.2 for 1.2%.
    double? dividendYield,
    double? trailingEps,
  }) = _Valuation;
}

/// Profitability, balance sheet and growth. Percentages are in percent.
@freezed
abstract class FinancialHealth with _$FinancialHealth {
  const factory FinancialHealth({
    double? roe,
    double? roce,
    double? debtToEquity,

    /// Rupees.
    double? freeCashFlow,
    double? profitMargin,
    double? operatingMargin,
    double? revenueGrowth,
    double? earningsGrowth,
    double? promoterHolding,
  }) = _FinancialHealth;
}

/// One year of an annual figure, in rupees.
@freezed
abstract class TrendPoint with _$TrendPoint {
  const factory TrendPoint({required String year, required double value}) = _TrendPoint;
}

/// One metric as the score graded it.
@freezed
abstract class ScoreMetric with _$ScoreMetric {
  const factory ScoreMetric({
    required String key,
    required String label,

    /// The value as the server formats it, e.g. `24.1x`.
    required String display,
    required Verdict verdict,
    required String note,
    double? value,
  }) = _ScoreMetric;
}

/// Valuation, Profitability, Balance sheet or Growth: up to [max] points.
@freezed
abstract class ScorePillar with _$ScorePillar {
  const factory ScorePillar({
    required String key,
    required String label,
    required String tagline,
    required double max,
    required List<ScoreMetric> metrics,

    /// Null when nothing in the pillar could be measured for this stock.
    double? score,
  }) = _ScorePillar;

  const ScorePillar._();

  /// 0–1, for a progress bar. Zero when unmeasured.
  double get fraction => score == null || max <= 0 ? 0 : (score! / max).clamp(0, 1);
}

/// The 0–100 fundamental score. Computed in Python against fixed thresholds,
/// with no AI involved: the same numbers always give the same score.
@freezed
abstract class FundamentalScore with _$FundamentalScore {
  const factory FundamentalScore({
    required String label,
    required ScoreConfidence confidence,
    required int metricsUsed,
    required int metricsTotal,
    required List<ScorePillar> pillars,
    required List<String> strengths,
    required List<String> concerns,

    /// Metric keys left out because they do not apply to this kind of
    /// company, e.g. debt-to-equity for a bank.
    required List<String> excluded,
    double? total,
    String? grade,
    String? note,
  }) = _FundamentalScore;

  const FundamentalScore._();

  bool get isScored => total != null;

  /// Too few metrics had data: shown grey and labelled provisional, since
  /// colour is what a beginner reads first.
  bool get isProvisional => confidence == ScoreConfidence.low;
}

/// `GET /api/research/fundamental`: Yahoo-backed ratios, trends and score.
@freezed
abstract class Fundamentals with _$Fundamentals {
  const factory Fundamentals({
    required String symbol,
    required Valuation valuation,
    required FinancialHealth health,
    required List<TrendPoint> revenueTrend,
    required List<TrendPoint> profitTrend,
    FundamentalScore? score,
    String? sector,
    String? industry,
  }) = _Fundamentals;
}

/// A plain-English reading of a stock's fundamentals, written by the server's
/// LLM. Markdown.
@freezed
abstract class AiSummary with _$AiSummary {
  const factory AiSummary({
    required String markdown,

    /// The server answered from its own cache rather than generating anew.
    required bool cached,
    required DateTime receivedAt,
  }) = _AiSummary;
}
