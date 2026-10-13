import 'dart:math' as math;
import 'dart:ui';

/// Geometry for an index-based time-series chart: point `i` of [count] sits
/// in the middle of its own slot, so candles and bars never overhang the
/// edges, and a finger's x maps back to exactly one point.
///
/// Pure, so the maths behind every chart is unit-tested.
class ChartScale {
  ChartScale({required this.count, required this.rect, required this.min, required this.max})
    : assert(count > 0, 'A chart needs at least one point'),
      assert(max > min, 'The value domain must have a width');

  final int count;
  final Rect rect;
  final double min;
  final double max;

  double get slot => rect.width / count;

  double x(int index) => rect.left + slot * (index + 0.5);

  double y(double value) => rect.bottom - (value - min) / (max - min) * rect.height;

  /// The point under [dx], clamped to the chart.
  int indexAt(double dx) => ((dx - rect.left) / slot).floor().clamp(0, count - 1);

  bool contains(double value) => value >= min && value <= max;
}

/// The range to draw [values] in, with breathing room above and below so the
/// line never touches the frame. A flat series gets a small range around its
/// value instead of a zero-width one.
({double min, double max}) paddedDomain(Iterable<double> values, {double padding = 0.08}) {
  var lo = double.infinity;
  var hi = double.negativeInfinity;
  for (final v in values) {
    if (!v.isFinite) continue;
    lo = math.min(lo, v);
    hi = math.max(hi, v);
  }
  if (!lo.isFinite) return (min: 0, max: 1);
  var range = hi - lo;
  if (range == 0) range = lo.abs() * 0.02 == 0 ? 1 : lo.abs() * 0.02;
  return (min: lo - range * padding, max: hi + range * padding);
}

/// Round-numbered gridline values inside [min]..[max], about [target] of them:
/// 2,400 / 2,450 / 2,500 rather than 2,413.7 / 2,461.2.
List<double> niceTicks(double min, double max, {int target = 4}) {
  if (!(max > min) || target < 1) return const [];
  final raw = (max - min) / target;
  final magnitude = math.pow(10, (math.log(raw) / math.ln10).floor()).toDouble();
  final normalized = raw / magnitude;
  final step =
      magnitude *
      (normalized < 1.5
          ? 1
          : normalized < 3
          ? 2
          : normalized < 7
          ? 5
          : 10);
  final first = (min / step).ceil();
  final last = (max / step).floor();
  // Built from integers so steps never accumulate drift, then rounded to the
  // step's precision so 3 × 0.1 labels as 0.3, not 0.30000000000000004.
  return [for (var i = first; i <= last; i++) double.parse((i * step).toStringAsPrecision(12))];
}

/// About [target] evenly spread indices for x-axis labels, always including
/// the first and last point.
List<int> labelIndices(int count, {int target = 4}) {
  if (count <= 0) return const [];
  if (count <= target) return [for (var i = 0; i < count; i++) i];
  return {for (var k = 0; k < target; k++) (k * (count - 1) / (target - 1)).round()}.toList();
}
