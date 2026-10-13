import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:agentfolio/core/presentation/charts/chart_palette.dart';
import 'package:agentfolio/core/presentation/charts/chart_scale.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One thing drawn against the shared time axis.
sealed class SeriesLayer {
  const SeriesLayer();
}

/// A line through the values, broken where a value is null (an indicator
/// before its window fills). [fill] shades beneath it.
final class LineLayer extends SeriesLayer {
  const LineLayer(this.values, {required this.color, this.width = 1.8, this.fill = false});

  final List<double?> values;
  final Color color;
  final double width;
  final bool fill;
}

/// Daily candles. Hollow-free: filled green when the day closed up.
final class CandleLayer extends SeriesLayer {
  const CandleLayer(this.bars);

  final List<CandleValue> bars;
}

typedef CandleValue = ({double open, double high, double low, double close});

/// Bars up or down from zero, e.g. the MACD histogram.
final class HistogramLayer extends SeriesLayer {
  const HistogramLayer(this.values);

  final List<double?> values;
}

/// A horizontal line at a value: an average buy price, an RSI threshold.
class ReferenceLine {
  const ReferenceLine(
    this.value, {
    required this.color,
    this.label,
    this.dashed = true,
    this.keepInView = false,
  });

  final double value;
  final Color color;
  final String? label;
  final bool dashed;

  /// Stretch the value range to show it when it is reasonably near the data.
  /// When it is far off, it is pinned to the edge with an arrow instead of
  /// squashing the chart flat.
  final bool keepInView;
}

/// A shaded horizontal zone, e.g. RSI's 30–70.
class ShadedBand {
  const ShadedBand(this.from, this.to, {required this.color});

  final double from;
  final double to;
  final Color color;
}

/// A price or indicator chart over daily points, drawn in one pass so the
/// optional volume pane lines up with the candles exactly.
///
/// Drag or press-and-hold to scrub: a crosshair follows the finger with a
/// light haptic tick per day, and [onScrub] reports the index so the card
/// can show that day's figures. It reports null when the finger lifts.
/// Only the crosshair repaints while scrubbing.
class TimeSeriesChart extends StatefulWidget {
  const TimeSeriesChart({
    required this.dates,
    required this.layers,
    required this.formatValue,
    required this.semanticLabel,
    super.key,
    this.references = const [],
    this.bands = const [],
    this.volumes,
    this.domain,
    this.onScrub,
    this.height = 220,
  });

  final List<DateTime> dates;
  final List<SeriesLayer> layers;
  final List<ReferenceLine> references;
  final List<ShadedBand> bands;

  /// Shown in a slim pane beneath, coloured by the candle's direction.
  final List<double>? volumes;

  /// A fixed value range, e.g. 0–100 for RSI. Otherwise fitted to the data.
  final ({double min, double max})? domain;
  final String Function(double value) formatValue;
  final ValueChanged<int?>? onScrub;
  final String semanticLabel;
  final double height;

  @override
  State<TimeSeriesChart> createState() => _TimeSeriesChartState();
}

class _TimeSeriesChartState extends State<TimeSeriesChart> {
  final _scrub = ValueNotifier<int?>(null);
  int? _lastHapticIndex;
  DateTime _lastHaptic = DateTime(0);
  _Geometry? _geometry;

  @override
  void dispose() {
    _scrub.dispose();
    super.dispose();
  }

  void _scrubTo(Offset local) {
    final geometry = _geometry;
    if (geometry == null) return;
    final index = geometry.scale.indexAt(local.dx);
    if (index == _scrub.value) return;
    _scrub.value = index;
    widget.onScrub?.call(index);
    // A tick per day, but never a buzz when the finger sweeps fast.
    final now = DateTime.now();
    if (index != _lastHapticIndex && now.difference(_lastHaptic).inMilliseconds > 40) {
      _lastHapticIndex = index;
      _lastHaptic = now;
      HapticFeedback.selectionClick().ignore();
    }
  }

  void _endScrub() {
    if (_scrub.value == null) return;
    _scrub.value = null;
    widget.onScrub?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dates.isEmpty) return SizedBox(height: widget.height);
    final labelStyle = Theme.of(context).textTheme.labelSmall!.copyWith(
      color: AppColors.textMuted,
      letterSpacing: 0,
      fontSize: 10,
      fontFeatures: AppTypography.tabular,
    );

    return Semantics(
      label: widget.semanticLabel,
      child: SizedBox(
        height: widget.height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final geometry = _geometry = _Geometry.of(
              widget,
              Size(constraints.maxWidth, widget.height),
              labelStyle,
            );
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: (d) => _scrubTo(d.localPosition),
              onHorizontalDragUpdate: (d) => _scrubTo(d.localPosition),
              onHorizontalDragEnd: (_) => _endScrub(),
              onHorizontalDragCancel: _endScrub,
              onLongPressStart: (d) => _scrubTo(d.localPosition),
              onLongPressMoveUpdate: (d) => _scrubTo(d.localPosition),
              onLongPressEnd: (_) => _endScrub(),
              onLongPressCancel: _endScrub,
              child: TweenAnimationBuilder<double>(
                // Draws in from the left on first paint and when the data
                // changes (the caller keys the chart by range).
                tween: Tween(begin: 0, end: 1),
                duration: AppMotion.of(context, const Duration(milliseconds: 650)),
                curve: Curves.easeOutCubic,
                builder: (context, progress, _) => Stack(
                  fit: StackFit.expand,
                  children: [
                    RepaintBoundary(
                      child: CustomPaint(
                        painter: _SeriesPainter(widget, geometry, labelStyle, progress),
                      ),
                    ),
                    CustomPaint(painter: _CrosshairPainter(widget, geometry, _scrub)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Where everything goes, worked out once per layout and shared by both
/// painters and the gesture handler.
class _Geometry {
  _Geometry({
    required this.scale,
    required this.volumeRect,
    required this.ticks,
    required this.pinned,
    required this.size,
  });

  factory _Geometry.of(TimeSeriesChart chart, Size size, TextStyle labelStyle) {
    final values = <double>[
      for (final layer in chart.layers)
        ...switch (layer) {
          LineLayer(:final values) || HistogramLayer(:final values) => values.whereType<double>(),
          CandleLayer(:final bars) => [
            for (final b in bars) ...[b.high, b.low],
          ],
        },
      if (chart.layers.any((l) => l is HistogramLayer)) 0,
    ];
    var domain = chart.domain ?? paddedDomain(values);

    // Pull a nearby reference line into view; pin a far one to the edge.
    final pinned = <ReferenceLine, bool>{};
    if (chart.domain == null) {
      final range = domain.max - domain.min;
      for (final ref in chart.references.where((r) => r.keepInView)) {
        if (ref.value >= domain.min - range * 0.5 && ref.value <= domain.max + range * 0.5) {
          domain = paddedDomain([...values, ref.value]);
        } else {
          pinned[ref] = ref.value > domain.max;
        }
      }
    }

    const xLabels = 18.0;
    final volumeHeight = chart.volumes == null ? 0.0 : size.height * 0.16;
    final ticks = niceTicks(domain.min, domain.max);
    final gutter = _gutterWidth(ticks, chart.formatValue, labelStyle);
    final plot = Rect.fromLTRB(
      0,
      8,
      size.width - gutter,
      size.height - xLabels - (volumeHeight > 0 ? volumeHeight + 6 : 0),
    );
    return _Geometry(
      scale: ChartScale(count: chart.dates.length, rect: plot, min: domain.min, max: domain.max),
      volumeRect: volumeHeight == 0
          ? null
          : Rect.fromLTWH(0, plot.bottom + 6, plot.width, volumeHeight),
      ticks: ticks,
      pinned: pinned,
      size: size,
    );
  }

  final ChartScale scale;
  final Rect? volumeRect;
  final List<double> ticks;

  /// Reference lines off the chart: true when above it, false when below.
  final Map<ReferenceLine, bool> pinned;
  final Size size;

  static double _gutterWidth(List<double> ticks, String Function(double) format, TextStyle style) {
    var widest = 0.0;
    for (final t in ticks) {
      final painter = TextPainter(
        text: TextSpan(text: format(t), style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      widest = math.max(widest, painter.width);
    }
    return widest + 10;
  }
}

class _SeriesPainter extends CustomPainter {
  _SeriesPainter(this.chart, this.geometry, this.labelStyle, this.progress);

  final TimeSeriesChart chart;
  final _Geometry geometry;
  final TextStyle labelStyle;
  final double progress;

  ChartScale get scale => geometry.scale;

  @override
  void paint(Canvas canvas, Size size) {
    _paintGrid(canvas);
    for (final band in chart.bands) {
      final top = scale.y(math.min(math.max(band.to, band.from), scale.max));
      final bottom = scale.y(math.max(math.min(band.from, band.to), scale.min));
      canvas.drawRect(
        Rect.fromLTRB(scale.rect.left, top, scale.rect.right, bottom),
        Paint()..color = band.color,
      );
    }

    // Everything data-driven is revealed left to right.
    canvas
      ..save()
      ..clipRect(
        Rect.fromLTWH(0, 0, scale.rect.left + scale.rect.width * progress, geometry.size.height),
      );
    _paintVolumes(canvas);
    for (final layer in chart.layers) {
      switch (layer) {
        case LineLayer():
          _paintLine(canvas, layer);
        case CandleLayer():
          _paintCandles(canvas, layer);
        case HistogramLayer():
          _paintHistogram(canvas, layer);
      }
    }
    canvas.restore();

    for (final ref in chart.references) {
      _paintReference(canvas, ref);
    }
    _paintDates(canvas);
  }

  void _paintGrid(Canvas canvas) {
    final grid = Paint()
      ..color = ChartPalette.grid
      ..strokeWidth = 1;
    for (final tick in geometry.ticks) {
      final y = scale.y(tick);
      canvas.drawLine(Offset(scale.rect.left, y), Offset(scale.rect.right, y), grid);
      _text(canvas, chart.formatValue(tick), Offset(scale.rect.right + 6, y), align: _Align.left);
    }
  }

  void _paintVolumes(Canvas canvas) {
    final volumes = chart.volumes;
    final rect = geometry.volumeRect;
    if (volumes == null || rect == null || volumes.isEmpty) return;
    final peak = volumes.reduce(math.max);
    if (peak <= 0) return;
    final candles = chart.layers.whereType<CandleLayer>().firstOrNull?.bars;
    final line = chart.layers.whereType<LineLayer>().firstOrNull?.values;
    final width = (scale.slot * 0.62).clamp(1.0, 10.0);
    for (var i = 0; i < math.min(volumes.length, scale.count); i++) {
      final up = candles != null
          ? candles[i].close >= candles[i].open
          : i == 0 || ((line?[i] ?? 0) >= (line?[i - 1] ?? 0));
      final h = volumes[i] / peak * rect.height;
      canvas.drawRect(
        Rect.fromLTWH(scale.x(i) - width / 2, rect.bottom - h, width, h),
        Paint()..color = (up ? AppColors.gain : AppColors.loss).withValues(alpha: 0.35),
      );
    }
  }

  void _paintLine(Canvas canvas, LineLayer layer) {
    final segments = <List<Offset>>[];
    var current = <Offset>[];
    for (var i = 0; i < math.min(layer.values.length, scale.count); i++) {
      final v = layer.values[i];
      if (v == null) {
        if (current.isNotEmpty) segments.add(current);
        current = [];
      } else {
        current.add(Offset(scale.x(i), scale.y(v)));
      }
    }
    if (current.isNotEmpty) segments.add(current);

    final stroke = Paint()
      ..color = layer.color
      ..strokeWidth = layer.width
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    for (final points in segments) {
      if (points.length == 1) {
        canvas.drawCircle(points.first, layer.width, Paint()..color = layer.color);
        continue;
      }
      final path = Path()..addPolygon(points, false);
      if (layer.fill) {
        final area = Path.from(path)
          ..lineTo(points.last.dx, scale.rect.bottom)
          ..lineTo(points.first.dx, scale.rect.bottom)
          ..close();
        canvas.drawPath(
          area,
          Paint()
            ..shader = ui.Gradient.linear(Offset(0, scale.rect.top), Offset(0, scale.rect.bottom), [
              layer.color.withValues(alpha: 0.24),
              layer.color.withValues(alpha: 0),
            ]),
        );
      }
      canvas.drawPath(path, stroke);
    }
  }

  void _paintCandles(Canvas canvas, CandleLayer layer) {
    final body = (scale.slot * 0.62).clamp(1.0, 12.0);
    final wick = Paint()..strokeWidth = math.min(1, body);
    final fill = Paint();
    for (var i = 0; i < math.min(layer.bars.length, scale.count); i++) {
      final b = layer.bars[i];
      final color = b.close >= b.open ? AppColors.gain : AppColors.loss;
      final x = scale.x(i);
      canvas.drawLine(Offset(x, scale.y(b.high)), Offset(x, scale.y(b.low)), wick..color = color);
      final top = scale.y(math.max(b.open, b.close));
      final bottom = scale.y(math.min(b.open, b.close));
      canvas.drawRect(
        // A doji still gets a visible 1px body.
        Rect.fromLTRB(x - body / 2, top, x + body / 2, math.max(bottom, top + 1)),
        fill..color = color,
      );
    }
  }

  void _paintHistogram(Canvas canvas, HistogramLayer layer) {
    final width = (scale.slot * 0.62).clamp(1.0, 10.0);
    final zero = scale.y(0);
    for (var i = 0; i < math.min(layer.values.length, scale.count); i++) {
      final v = layer.values[i];
      if (v == null) continue;
      final y = scale.y(v);
      canvas.drawRect(
        Rect.fromLTRB(
          scale.x(i) - width / 2,
          math.min(y, zero),
          scale.x(i) + width / 2,
          math.max(y, zero),
        ),
        Paint()..color = (v >= 0 ? AppColors.gain : AppColors.loss).withValues(alpha: 0.55),
      );
    }
  }

  void _paintReference(Canvas canvas, ReferenceLine ref) {
    final above = geometry.pinned[ref];
    if (above == null && !scale.contains(ref.value)) return;
    final paint = Paint()
      ..color = ref.color.withValues(alpha: above == null ? 0.9 : 0.5)
      ..strokeWidth = 1.2;
    final y = above == null ? scale.y(ref.value) : (above ? scale.rect.top : scale.rect.bottom);

    if (above == null) {
      if (ref.dashed) {
        for (var x = scale.rect.left; x < scale.rect.right; x += 9) {
          canvas.drawLine(Offset(x, y), Offset(math.min(x + 5, scale.rect.right), y), paint);
        }
      } else {
        canvas.drawLine(Offset(scale.rect.left, y), Offset(scale.rect.right, y), paint);
      }
    }

    final label = ref.label;
    if (label == null) return;
    final text = above == null ? label : '$label ${above ? '↑' : '↓'}';
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: labelStyle.copyWith(color: ref.color, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final pill = Rect.fromLTWH(
      scale.rect.left + 4,
      (y - painter.height / 2 - 3).clamp(0, geometry.size.height - painter.height - 6),
      painter.width + 10,
      painter.height + 6,
    );
    final shape = RRect.fromRectAndRadius(pill, const Radius.circular(5));
    canvas
      ..drawRRect(shape, Paint()..color = AppColors.background.withValues(alpha: 0.85))
      ..drawRRect(
        shape,
        Paint()
          ..color = ref.color.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke,
      );
    painter.paint(canvas, pill.topLeft + const Offset(5, 3));
  }

  void _paintDates(Canvas canvas) {
    final dates = chart.dates;
    final span = dates.last.difference(dates.first).inDays;
    String format(DateTime d) {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final m = months[d.month - 1];
      // Day and month for a few months; month and year for longer.
      return span > 120 ? "$m '${(d.year % 100).toString().padLeft(2, '0')}" : '${d.day} $m';
    }

    final y = geometry.size.height - 14;
    final indices = labelIndices(scale.count);
    for (final i in indices) {
      final align = i == indices.first
          ? _Align.left
          : i == indices.last
          ? _Align.right
          : _Align.center;
      final x = switch (align) {
        _Align.left => scale.rect.left,
        _Align.right => scale.rect.right,
        _Align.center => scale.x(i),
      };
      _text(canvas, format(dates[i]), Offset(x, y + 7), align: align);
    }
  }

  void _text(Canvas canvas, String text, Offset anchor, {required _Align align}) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: labelStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    final dx = switch (align) {
      _Align.left => anchor.dx,
      _Align.center => anchor.dx - painter.width / 2,
      _Align.right => anchor.dx - painter.width,
    };
    painter.paint(canvas, Offset(dx, anchor.dy - painter.height / 2));
  }

  @override
  bool shouldRepaint(_SeriesPainter old) =>
      old.chart != chart || old.progress != progress || old.geometry.size != geometry.size;
}

enum _Align { left, center, right }

/// The scrub crosshair: a vertical line at the day and a dot on the main
/// series. Repaints on its own, so scrubbing never redraws the series.
class _CrosshairPainter extends CustomPainter {
  _CrosshairPainter(this.chart, this.geometry, this.index) : super(repaint: index);

  final TimeSeriesChart chart;
  final _Geometry geometry;
  final ValueNotifier<int?> index;

  @override
  void paint(Canvas canvas, Size size) {
    final i = index.value;
    if (i == null) return;
    final scale = geometry.scale;
    final x = scale.x(i);
    final bottom = geometry.volumeRect?.bottom ?? scale.rect.bottom;
    canvas.drawLine(
      Offset(x, scale.rect.top),
      Offset(x, bottom),
      Paint()
        ..color = AppColors.textSecondary.withValues(alpha: 0.6)
        ..strokeWidth = 1,
    );
    // The dot rides the main series: the first line or candles, not bars.
    final main =
        chart.layers.firstWhereOrNull((l) => l is! HistogramLayer) ?? chart.layers.firstOrNull;
    final value = switch (main) {
      LineLayer(:final values) || HistogramLayer(:final values) when i < values.length => values[i],
      CandleLayer(:final bars) when i < bars.length => bars[i].close,
      _ => null,
    };
    if (value == null) return;
    final color = switch (main) {
      LineLayer(:final color) => color,
      _ => AppColors.textPrimary,
    };
    final point = Offset(x, scale.y(value));
    canvas
      ..drawCircle(point, 7, Paint()..color = color.withValues(alpha: 0.25))
      ..drawCircle(point, 4, Paint()..color = color)
      ..drawCircle(
        point,
        4,
        Paint()
          ..color = AppColors.background
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
  }

  @override
  bool shouldRepaint(_CrosshairPainter old) => old.geometry != geometry || old.chart != chart;
}
