import 'dart:math' as math;

import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:flutter/material.dart';

/// A three-quarter ring split between parts, e.g. invested vs cash, with
/// whatever [center] shows inside it. The segments sweep in on first paint.
class RingGauge extends StatelessWidget {
  const RingGauge({
    required this.parts,
    required this.center,
    required this.semanticLabel,
    super.key,
    this.size = 200,
  });

  final List<({double value, Color color})> parts;
  final Widget center;
  final String semanticLabel;
  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    child: SizedBox.square(
      dimension: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: AppMotion.of(context, const Duration(milliseconds: 900)),
        curve: Curves.easeOutCubic,
        builder: (context, progress, child) => CustomPaint(
          painter: _RingPainter(parts: parts, progress: progress),
          child: child,
        ),
        child: Center(child: ExcludeSemantics(child: center)),
      ),
    ),
  );
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.parts, required this.progress});

  final List<({double value, Color color})> parts;
  final double progress;

  static const double _start = math.pi * 0.75; // bottom-left
  static const double _sweep = math.pi * 1.5; // three quarters
  static const _gap = 0.06;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.09;
    final rect = (Offset.zero & size).deflate(stroke / 2 + 2);
    Paint arc(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, _start, _sweep, false, arc(AppColors.surfaceRaised));

    final total = parts.fold<double>(0, (sum, p) => sum + math.max(p.value, 0));
    if (total <= 0) return;
    final visible = parts.where((p) => p.value > 0).toList();
    final gaps = _gap * (visible.length - 1);
    var angle = _start;
    for (final part in visible) {
      final sweep = (_sweep - gaps) * (part.value / total) * progress;
      if (sweep > 0.001) canvas.drawArc(rect, angle, sweep, false, arc(part.color));
      angle += sweep + _gap * progress;
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress || old.parts != parts;
}
