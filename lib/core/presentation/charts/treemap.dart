import 'package:agentfolio/core/presentation/charts/squarify.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One tile of a [Treemap].
@immutable
class TreemapTile {
  const TreemapTile({required this.label, required this.value, required this.color, this.caption});

  final String label;

  /// Decides the tile's area.
  final double value;
  final Color color;

  /// Second line, e.g. `+4.2%`.
  final String? caption;
}

/// A tappable treemap. Tiles must be sorted largest first. Labels appear only
/// on tiles big enough to read them; the rest stay tappable.
class Treemap extends StatelessWidget {
  const Treemap({
    required this.tiles,
    required this.onTap,
    required this.semanticLabel,
    super.key,
    this.height = 240,
  });

  final List<TreemapTile> tiles;
  final ValueChanged<int> onTap;
  final String semanticLabel;
  final double height;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    child: SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, height);
          final rects = squarify([for (final t in tiles) t.value], Offset.zero & size);
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: AppMotion.of(context, AppMotion.long),
            curve: AppMotion.enter,
            builder: (context, progress, _) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                final index = rects.indexWhere((r) => r.contains(details.localPosition));
                if (index < 0) return;
                HapticFeedback.selectionClick().ignore();
                onTap(index);
              },
              child: RepaintBoundary(
                child: CustomPaint(
                  size: size,
                  painter: _TreemapPainter(
                    tiles: tiles,
                    rects: rects,
                    progress: progress,
                    labelStyle: Theme.of(context).textTheme.labelLarge!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                    captionStyle: Theme.of(context).textTheme.labelMedium!.tabular
                        .copyWith(color: Colors.white.withValues(alpha: 0.85)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class _TreemapPainter extends CustomPainter {
  _TreemapPainter({
    required this.tiles,
    required this.rects,
    required this.progress,
    required this.labelStyle,
    required this.captionStyle,
  });

  final List<TreemapTile> tiles;
  final List<Rect> rects;
  final double progress;
  final TextStyle labelStyle;
  final TextStyle captionStyle;

  static const _gap = 3.0;
  static const _minLabelSize = 9.0;
  static const _radius = Radius.circular(6);

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < tiles.length; i++) {
      final rect = rects[i].deflate(_gap / 2);
      if (rect.width <= 0 || rect.height <= 0) continue;
      // Tiles grow out from their own centre as the map appears.
      final shown = Rect.fromCenter(
        center: rect.center,
        width: rect.width * progress,
        height: rect.height * progress,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(shown, _radius),
        Paint()..color = tiles[i].color.withValues(alpha: progress),
      );
      if (progress > 0.85) _paintLabel(canvas, rect, tiles[i]);
    }
  }

  void _paintLabel(Canvas canvas, Rect rect, TreemapTile tile) {
    if (rect.width < 44 || rect.height < 28) return;
    final maxWidth = rect.width - 12;
    // Shrink a long label (ETF names) to fit before resorting to "…".
    var style = labelStyle;
    final natural = TextPainter(
      text: TextSpan(text: tile.label, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    if (natural.width > maxWidth) {
      final fitted = (style.fontSize ?? 14) * maxWidth / natural.width;
      style = style.copyWith(fontSize: fitted.clamp(_minLabelSize, style.fontSize ?? 14));
    }
    final label = TextPainter(
      text: TextSpan(text: tile.label, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: maxWidth);
    final caption = tile.caption == null || rect.height < 46
        ? null
        : (TextPainter(
            text: TextSpan(text: tile.caption, style: captionStyle),
            textDirection: TextDirection.ltr,
            maxLines: 1,
          )..layout(maxWidth: maxWidth));
    final total = label.height + (caption?.height ?? 0);
    var y = rect.center.dy - total / 2;
    label.paint(canvas, Offset(rect.left + 6 + (maxWidth - label.width) / 2, y));
    y += label.height;
    caption?.paint(canvas, Offset(rect.left + 6 + (maxWidth - caption.width) / 2, y));
  }

  @override
  bool shouldRepaint(_TreemapPainter old) =>
      old.progress != progress || !identical(old.tiles, tiles) || old.rects.length != rects.length;
}
