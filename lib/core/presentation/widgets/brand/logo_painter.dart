import 'dart:math' as math;

import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/rendering.dart';

/// How far along each part of the logo is, 0 (absent) to 1 (drawn).
///
/// The splash animates these independently. Bars may exceed 1 briefly for an
/// overshoot, and [dotScale] runs 0 → 1.15 → 1 for its pop.
@immutable
class LogoProgress {
  const LogoProgress({
    this.border = 1,
    this.fill = 1,
    this.bars = const [1, 1, 1],
    this.line = 1,
    this.dotScale = 1,
    this.glow = 0,
  });

  /// The finished mark, for static use.
  static const complete = LogoProgress();

  /// Nothing drawn yet: the splash's first frame, identical to the native
  /// launch screen.
  static const empty = LogoProgress(border: 0, fill: 0, bars: [0, 0, 0], line: 0, dotScale: 0);

  final double border;
  final double fill;
  final List<double> bars;
  final double line;
  final double dotScale;

  /// Halo behind the dot, 0–1. The splash breathes it while it waits.
  final double glow;
}

/// The Agentfolio mark, painted from the app icon's own geometry
/// (`assets/icon/app_icon.svg`), so the splash and the icon can never drift
/// apart.
///
/// All coordinates are in the SVG's units: a 170-unit rounded square centred
/// on the origin.
class LogoPainter extends CustomPainter {
  const LogoPainter(this.progress);

  final LogoProgress progress;

  // Geometry from app_icon.svg.
  static const _half = 85.0;
  static const _cornerRadius = 38.0;
  static const _strokeWidth = 7.0;

  /// The extent the mark occupies including its stroke, used to scale it into
  /// whatever size the widget is given.
  static const double _extent = (_half + _strokeWidth / 2) * 2;

  static const List<({double left, double top, double height, Color color, double opacity})> _bars =
      [
        (left: -50.0, top: 12.0, height: 46.0, color: AppColors.emerald, opacity: 0.85),
        (left: -14.0, top: -14.0, height: 72.0, color: AppColors.sky, opacity: 0.9),
        (left: 22.0, top: -44.0, height: 102.0, color: AppColors.indigo, opacity: 1.0),
      ];
  static const _barWidth = 24.0;
  static const _barRadius = Radius.circular(7);
  static const _barBottom = 58.0;

  static const List<Offset> _linePoints = [
    Offset(-38, 12),
    Offset(-2, -14),
    Offset(34, -46),
    Offset(58, -72),
  ];
  static const _dotRadius = 9.0;

  static final RRect _box = RRect.fromRectAndRadius(
    const Rect.fromLTRB(-_half, -_half, _half, _half),
    const Radius.circular(_cornerRadius),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(size.width, size.height) / _extent;
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..scale(scale);

    final gradientShader = AppColors.brandGradient.createShader(_box.outerRect);

    _paintFill(canvas, gradientShader);
    _paintBorder(canvas, gradientShader);
    _paintBars(canvas);
    _paintLine(canvas);
    _paintDot(canvas);

    canvas.restore();
  }

  void _paintFill(Canvas canvas, Shader shader) {
    if (progress.fill <= 0) return;
    canvas.drawRRect(
      _box,
      Paint()
        ..shader = shader
        ..color = Color.fromRGBO(0, 0, 0, 0.14 * progress.fill.clamp(0, 1)),
    );
  }

  void _paintBorder(Canvas canvas, Shader shader) {
    if (progress.border <= 0) return;
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    // Start the trace at the top-left corner and run clockwise.
    final path = Path()..addRRect(_box);
    canvas.drawPath(_trim(path, progress.border), paint);
  }

  void _paintBars(Canvas canvas) {
    for (var i = 0; i < _bars.length; i++) {
      final grow = i < progress.bars.length ? progress.bars[i] : 1.0;
      if (grow <= 0) continue;
      final bar = _bars[i];
      final height = bar.height * grow;
      final rect = Rect.fromLTRB(bar.left, _barBottom - height, bar.left + _barWidth, _barBottom);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, _barRadius),
        Paint()..color = bar.color.withValues(alpha: bar.opacity),
      );
    }
  }

  void _paintLine(Canvas canvas) {
    if (progress.line <= 0) return;
    final path = Path()..addPolygon(_linePoints, false);
    canvas.drawPath(
      _trim(path, progress.line),
      Paint()
        ..color =
            const Color(0x8CFFFFFF) // white at 55%, as in the icon
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _paintDot(Canvas canvas) {
    final centre = _linePoints.last;
    if (progress.glow > 0) {
      canvas.drawCircle(
        centre,
        _dotRadius * (1.8 + progress.glow),
        Paint()
          ..color = AppColors.emerald.withValues(alpha: 0.28 * progress.glow)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      );
    }
    if (progress.dotScale <= 0) return;
    canvas.drawCircle(centre, _dotRadius * progress.dotScale, Paint()..color = AppColors.emerald);
  }

  /// The first [fraction] of [path], measured along its length.
  static Path _trim(Path path, double fraction) {
    if (fraction >= 1) return path;
    final result = Path();
    final metrics = path.computeMetrics().toList();
    final total = metrics.fold<double>(0, (sum, m) => sum + m.length);
    var remaining = total * fraction.clamp(0, 1);
    for (final metric in metrics) {
      if (remaining <= 0) break;
      final take = math.min(remaining, metric.length);
      result.addPath(metric.extractPath(0, take), Offset.zero);
      remaining -= take;
    }
    return result;
  }

  @override
  bool shouldRepaint(LogoPainter oldDelegate) => oldDelegate.progress != progress;
}
