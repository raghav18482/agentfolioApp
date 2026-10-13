import 'dart:math' as math;
import 'dart:ui';

/// Lays out [values] as rectangles filling [bounds], each with area
/// proportional to its value, kept as close to square as possible
/// (Bruls, Huizing & van Wijk's squarified treemap).
///
/// [values] must be sorted largest first. Returns one rect per value, in the
/// same order. Zero and negative values get an empty rect.
List<Rect> squarify(List<double> values, Rect bounds) {
  final result = List<Rect>.filled(values.length, Rect.zero);
  final total = values.fold<double>(0, (sum, v) => sum + math.max(v, 0));
  if (total <= 0 || bounds.isEmpty) return result;

  final scale = bounds.width * bounds.height / total;
  final areas = [for (final v in values) math.max(v, 0) * scale];

  var rect = bounds;
  var start = 0;
  while (start < areas.length) {
    final side = math.min(rect.width, rect.height);
    var end = start + 1;
    var best = _worst(areas, start, end, side);
    while (end < areas.length) {
      final candidate = _worst(areas, start, end + 1, side);
      if (candidate > best) break;
      best = candidate;
      end++;
    }
    rect = _layoutRow(areas, start, end, rect, result);
    start = end;
  }
  return result;
}

/// The worst aspect ratio in areas[start, end) laid along a side of [side].
double _worst(List<double> areas, int start, int end, double side) {
  var sum = 0.0;
  var min = double.infinity;
  var max = 0.0;
  for (var i = start; i < end; i++) {
    sum += areas[i];
    min = math.min(min, areas[i]);
    max = math.max(max, areas[i]);
  }
  if (sum == 0 || min == 0) return double.infinity;
  final s2 = sum * sum;
  final w2 = side * side;
  return math.max(w2 * max / s2, s2 / (w2 * min));
}

/// Places one row along the shorter side of [rect] and returns what is left.
Rect _layoutRow(List<double> areas, int start, int end, Rect rect, List<Rect> out) {
  var sum = 0.0;
  for (var i = start; i < end; i++) {
    sum += areas[i];
  }
  if (rect.width >= rect.height) {
    // A column down the left edge.
    final width = rect.height == 0 ? 0.0 : sum / rect.height;
    var y = rect.top;
    for (var i = start; i < end; i++) {
      final h = width == 0 ? 0.0 : areas[i] / width;
      out[i] = Rect.fromLTWH(rect.left, y, width, h);
      y += h;
    }
    return Rect.fromLTRB(rect.left + width, rect.top, rect.right, rect.bottom);
  }
  // A row across the top edge.
  final height = rect.width == 0 ? 0.0 : sum / rect.width;
  var x = rect.left;
  for (var i = start; i < end; i++) {
    final w = height == 0 ? 0.0 : areas[i] / height;
    out[i] = Rect.fromLTWH(x, rect.top, w, height);
    x += w;
  }
  return Rect.fromLTRB(rect.left, rect.top + height, rect.right, rect.bottom);
}
