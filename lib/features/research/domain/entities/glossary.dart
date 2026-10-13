import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'glossary.freezed.dart';

/// One grading band: values up to [max] (or anything above the previous band
/// when [max] is null) read as [verdict].
@freezed
abstract class GlossaryBand with _$GlossaryBand {
  const factory GlossaryBand({required Verdict verdict, required String note, double? max}) =
      _GlossaryBand;
}

/// What a metric means and where "good" starts. Written by hand, not by AI,
/// and holding the exact thresholds the scorer grades against.
@freezed
abstract class GlossaryMetric with _$GlossaryMetric {
  const factory GlossaryMetric({
    required String key,
    required String label,
    required String fullName,
    required String pillar,
    required double weight,
    required String formula,
    required String plain,
    required String ideal,
    required List<GlossaryBand> bands,
    required String caveat,
    required String watchOut,
  }) = _GlossaryMetric;

  const GlossaryMetric._();

  /// Counts toward the score, rather than being shown for context only.
  bool get isScored => weight > 0;
}

@freezed
abstract class GlossaryPillar with _$GlossaryPillar {
  const factory GlossaryPillar({
    required String key,
    required String label,
    required String tagline,
    required String body,
  }) = _GlossaryPillar;
}

@freezed
abstract class GlossaryIntro with _$GlossaryIntro {
  const factory GlossaryIntro({required String title, required String body}) = _GlossaryIntro;
}

@freezed
abstract class GradeBand with _$GradeBand {
  const factory GradeBand({required double min, required String grade, required String label}) =
      _GradeBand;
}

@freezed
abstract class ScoringGuide with _$ScoringGuide {
  const factory ScoringGuide({
    required List<GradeBand> grades,
    required List<String> howItWorks,
    required String limits,
  }) = _ScoringGuide;
}

/// `static/data/metric_glossary.json`, shared by the metric ⓘ sheets and
/// Learn. The same file the Python scorer reads its bands from.
@freezed
abstract class Glossary with _$Glossary {
  const factory Glossary({
    required List<GlossaryIntro> intro,

    /// In the order the score and the guide present them.
    required List<GlossaryPillar> pillars,

    /// In the file's order, which groups them by pillar.
    required Map<String, GlossaryMetric> metrics,
    required ScoringGuide scoring,
  }) = _Glossary;

  const Glossary._();

  List<GlossaryMetric> metricsFor(String pillar) => [
    for (final m in metrics.values)
      if (m.pillar == pillar) m,
  ];
}
