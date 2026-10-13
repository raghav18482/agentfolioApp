import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';

/// Pure readings of research data, ported with their tests from the web app's
/// `lib/glossary.ts`, `lib/prediction.ts` and `ScoreCard.tsx`, so both
/// clients explain a stock the same way.

// ── Glossary ────────────────────────────────────────────────────────────────

/// The values one grading band covers, worked out from its own upper bound
/// and the band before it.
sealed class BandRange {
  const BandRange();
}

/// The only band, with no bounds at all.
final class AnyValue extends BandRange {
  const AnyValue();
}

final class UpTo extends BandRange {
  const UpTo(this.max);
  final double max;
}

final class Between extends BandRange {
  const Between(this.from, this.to);
  final double from;
  final double to;
}

final class Above extends BandRange {
  const Above(this.from);
  final double from;
}

BandRange bandRange(List<GlossaryBand> bands, int index) {
  final max = bands[index].max;
  final previous = index > 0 ? bands[index - 1].max : null;
  if (max == null) return previous == null ? const AnyValue() : Above(previous);
  if (previous == null) return UpTo(max);
  return Between(previous, max);
}

// ── Score ───────────────────────────────────────────────────────────────────

/// What the score left out, in words: a whole skipped pillar by name rather
/// than its metrics one by one, then any other excluded metric by label.
({List<String> pillars, List<String> metrics}) skippedParts(FundamentalScore score) {
  final skipped = [
    for (final p in score.pillars)
      if (p.score == null && p.metrics.any((m) => m.verdict == Verdict.excluded)) p,
  ];
  final inSkipped = {
    for (final p in skipped)
      for (final m in p.metrics) m.key,
  };
  final labels = {
    for (final p in score.pillars)
      for (final m in p.metrics) m.key: m.label,
  };
  return (
    pillars: [for (final p in skipped) p.label],
    metrics: [
      for (final key in score.excluded)
        if (!inSkipped.contains(key)) labels[key] ?? key,
    ],
  );
}

/// Each graded metric by key, so a metric row finds its verdict directly.
Map<String, ScoreMetric> verdictsByKey(FundamentalScore? score) => {
  for (final p in score?.pillars ?? const <ScorePillar>[])
    for (final m in p.metrics) m.key: m,
};

// ── Prediction ──────────────────────────────────────────────────────────────

enum Leaning { bullish, bearish, neutral }

/// Where a call sits on a 0–100 "chance of going up" axis: its confidence for
/// an up call, the complement for a down call, the midpoint for neutral.
double upwardPercent(HorizonCall call) {
  final value = switch (call.direction) {
    Direction.up => call.confidence * 100,
    Direction.down => (1 - call.confidence) * 100,
    Direction.neutral => 50.0,
  };
  return (value * 10).round() / 10;
}

/// Above 55 leans bullish, below 45 bearish, between is neutral.
Leaning leaningOf(double upwardPercent) => upwardPercent > 55
    ? Leaning.bullish
    : upwardPercent < 45
    ? Leaning.bearish
    : Leaning.neutral;

Leaning leaningOfDirection(Direction direction) => switch (direction) {
  Direction.up => Leaning.bullish,
  Direction.down => Leaning.bearish,
  Direction.neutral => Leaning.neutral,
};

Leaning leaningOfOutlook(Outlook outlook) => switch (outlook) {
  Outlook.bullish => Leaning.bullish,
  Outlook.bearish => Leaning.bearish,
  Outlook.neutral => Leaning.neutral,
};

/// A model version short enough to show, or null for the rule-based engine,
/// which must never be presented as a model.
String? shownModelVersion(Prediction p) {
  if (p.isHeuristic) return null;
  final v = p.modelVersion;
  if (v == null || v.isEmpty) return '';
  return v.length > 8 ? v.substring(0, 8) : v;
}
