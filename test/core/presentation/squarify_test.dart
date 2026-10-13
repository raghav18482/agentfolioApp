import 'dart:ui';

import 'package:agentfolio/core/presentation/charts/squarify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const bounds = Rect.fromLTWH(0, 0, 400, 240);

  test('areas are proportional to values and fill the bounds', () {
    final values = <double>[500, 300, 120, 50, 20, 10];
    final rects = squarify(values, bounds);
    final total = values.reduce((a, b) => a + b);
    final area = bounds.width * bounds.height;
    for (var i = 0; i < values.length; i++) {
      final r = rects[i];
      expect(r.width * r.height, closeTo(values[i] / total * area, 0.5));
      expect(bounds.inflate(0.01).contains(r.topLeft), isTrue);
      expect(bounds.inflate(0.01).contains(r.bottomRight), isTrue);
    }
    final sum = rects.fold<double>(0, (s, r) => s + r.width * r.height);
    expect(sum, closeTo(area, 1));
  });

  test('tiles stay reasonably square', () {
    final rects = squarify(<double>[40, 30, 20, 10, 10, 5, 5], bounds);
    for (final r in rects) {
      final ratio = r.width > r.height ? r.width / r.height : r.height / r.width;
      expect(ratio, lessThan(4));
    }
  });

  test('degenerate inputs do not throw', () {
    expect(squarify([], bounds), isEmpty);
    expect(squarify([0, 0], bounds), [Rect.zero, Rect.zero]);
    expect(squarify([1, 2], Rect.zero), [Rect.zero, Rect.zero]);
  });
}
