import 'package:freezed_annotation/freezed_annotation.dart';

part 'prediction.freezed.dart';

enum Direction { up, down, neutral }

enum Outlook { bullish, bearish, neutral }

/// Three horizons only: intraday was never tractable from daily bars, and a
/// year is a valuation question.
enum Horizon {
  day('1day'),
  week('1week'),
  month('1month');

  Horizon(this.wire);

  /// The key the server uses.
  final String wire;
}

@freezed
abstract class HorizonCall with _$HorizonCall {
  const factory HorizonCall({
    required Direction direction,

    /// How sure the engine is of [direction], 0–1. Not a calibrated
    /// probability for the rule-based engine.
    required double confidence,
    required double score,
    double? probabilityUp,
    bool? calibrated,
  }) = _HorizonCall;
}

/// A feature that pushed the outlook one way, with the value it had.
@freezed
abstract class PredictionSignal with _$PredictionSignal {
  const factory PredictionSignal({required String feature, double? value}) = _PredictionSignal;
}

/// `GET /api/portfolio/predict`: a direction outlook over three horizons.
@freezed
abstract class Prediction with _$Prediction {
  const factory Prediction({
    required String symbol,
    required Map<Horizon, HorizonCall> calls,
    required Outlook outlook,
    required double overallScore,

    /// `heuristic` when no trained model is registered: a rule-based score.
    required String modelType,
    required List<PredictionSignal> bullishSignals,
    required List<PredictionSignal> bearishSignals,
    String? modelVersion,
    bool? calibrated,

    /// The server's own caveat, shown verbatim.
    String? disclaimer,
  }) = _Prediction;

  const Prediction._();

  /// Rule-based, not a model. Must never read as a model's output.
  bool get isHeuristic => modelType == 'heuristic';

  /// The confidence shown needs the "not a calibrated probability" notice.
  bool get needsCalibrationNotice => isHeuristic || calibrated == false;
}
