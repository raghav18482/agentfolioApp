import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/logic/research_logic.dart';
import 'package:flutter_test/flutter_test.dart';

/// Ported from the web app's `glossary.test.ts` and `prediction.test.ts`,
/// plus the score helpers that lived inline in `ScoreCard.tsx`.
void main() {
  group('bandRange', () {
    GlossaryBand band(double? max) => GlossaryBand(max: max, verdict: Verdict.good, note: '');
    final bands = [band(0), band(10), band(25), band(null)];

    test('describes each band from its neighbours', () {
      expect(bandRange(bands, 0), isA<UpTo>().having((r) => r.max, 'max', 0));
      expect(
        bandRange(bands, 1),
        isA<Between>().having((r) => r.from, 'from', 0).having((r) => r.to, 'to', 10),
      );
      expect(
        bandRange(bands, 2),
        isA<Between>().having((r) => r.from, 'from', 10).having((r) => r.to, 'to', 25),
      );
      expect(bandRange(bands, 3), isA<Above>().having((r) => r.from, 'from', 25));
    });

    test('treats a lone open band as any value', () {
      expect(bandRange([band(null)], 0), isA<AnyValue>());
    });
  });

  test('metricsFor keeps the file order and filters by pillar', () {
    GlossaryMetric metric(String key, String pillar) => GlossaryMetric(
      key: key,
      label: key,
      fullName: '',
      pillar: pillar,
      weight: 1,
      formula: '',
      plain: '',
      ideal: '',
      bands: const [],
      caveat: '',
      watchOut: '',
    );
    final glossary = Glossary(
      intro: const [],
      pillars: const [],
      metrics: {
        'pe': metric('pe', 'valuation'),
        'roe': metric('roe', 'profitability'),
        'pb': metric('pb', 'valuation'),
      },
      scoring: const ScoringGuide(grades: [], howItWorks: [], limits: ''),
    );
    expect(glossary.metricsFor('valuation').map((m) => m.key), ['pe', 'pb']);
  });

  group('prediction', () {
    Prediction prediction({required String type, String? version, bool? calibrated}) => Prediction(
      symbol: 'X',
      calls: const {},
      outlook: Outlook.neutral,
      overallScore: 0,
      modelType: type,
      modelVersion: version,
      calibrated: calibrated,
      bullishSignals: const [],
      bearishSignals: const [],
    );

    test('never presents the rule-based fallback as a model', () {
      expect(shownModelVersion(prediction(type: 'heuristic')), isNull);
      // Even if a version somehow accompanies it.
      expect(shownModelVersion(prediction(type: 'heuristic', version: 'abcdef123456')), isNull);
    });

    test('shows a registered model with a short version', () {
      expect(
        shownModelVersion(prediction(type: 'xgboost', version: '0123456789abcdef')),
        '01234567',
      );
      expect(shownModelVersion(prediction(type: 'xgboost')), '');
    });

    test('flags the heuristic and any uncalibrated model for the notice', () {
      expect(prediction(type: 'heuristic').needsCalibrationNotice, isTrue);
      expect(prediction(type: 'xgboost', calibrated: false).needsCalibrationNotice, isTrue);
      expect(prediction(type: 'xgboost', calibrated: true).needsCalibrationNotice, isFalse);
      expect(prediction(type: 'xgboost').needsCalibrationNotice, isFalse);
    });

    test('upwardPercent maps direction and confidence onto a chance-of-rising axis', () {
      HorizonCall call(Direction d, double c) => HorizonCall(direction: d, confidence: c, score: 0);
      expect(upwardPercent(call(Direction.up, 0.7)), 70);
      expect(upwardPercent(call(Direction.down, 0.7)), 30);
      expect(upwardPercent(call(Direction.neutral, 0.9)), 50);
    });

    test('leaning uses the 45/55 band', () {
      expect(leaningOf(55.1), Leaning.bullish);
      expect(leaningOf(55), Leaning.neutral);
      expect(leaningOf(45), Leaning.neutral);
      expect(leaningOf(44.9), Leaning.bearish);
    });
  });

  group('score', () {
    ScoreMetric m(String key, Verdict v) =>
        ScoreMetric(key: key, label: key.toUpperCase(), display: '', verdict: v, note: '');

    final score = FundamentalScore(
      total: 60,
      label: 'Average',
      confidence: ScoreConfidence.high,
      metricsUsed: 3,
      metricsTotal: 5,
      strengths: const [],
      concerns: const [],
      excluded: const ['debt_to_equity', 'net_cash', 'ev_ebitda'],
      pillars: [
        ScorePillar(
          key: 'valuation',
          label: 'Valuation',
          tagline: '',
          max: 25,
          score: 20,
          metrics: [m('pe_ratio', Verdict.good), m('ev_ebitda', Verdict.excluded)],
        ),
        ScorePillar(
          key: 'balance_sheet',
          label: 'Balance sheet',
          tagline: '',
          max: 25,
          metrics: [m('debt_to_equity', Verdict.excluded), m('net_cash', Verdict.excluded)],
        ),
      ],
    );

    test('names a skipped pillar once instead of its metrics', () {
      final skipped = skippedParts(score);
      expect(skipped.pillars, ['Balance sheet']);
      expect(skipped.metrics, ['EV_EBITDA']);
    });

    test('verdictsByKey finds every graded metric', () {
      expect(verdictsByKey(score).keys, containsAll(['pe_ratio', 'ev_ebitda', 'net_cash']));
      expect(verdictsByKey(null), isEmpty);
    });

    test('an unmeasured pillar draws an empty bar', () {
      expect(score.pillars[0].fraction, 0.8);
      expect(score.pillars[1].fraction, 0);
    });
  });
}
