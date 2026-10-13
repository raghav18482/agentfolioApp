import 'dart:ui';

import 'package:agentfolio/core/presentation/charts/chart_scale.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChartScale', () {
    final scale = ChartScale(count: 4, rect: const Rect.fromLTWH(0, 0, 400, 100), min: 0, max: 50);

    test('centres each point in its own slot', () {
      expect([for (var i = 0; i < 4; i++) scale.x(i)], [50, 150, 250, 350]);
    });

    test('maps values bottom-up', () {
      expect(scale.y(0), 100);
      expect(scale.y(50), 0);
      expect(scale.y(25), 50);
    });

    test('a finger anywhere maps to exactly one point, clamped to the chart', () {
      expect(scale.indexAt(-30), 0);
      expect(scale.indexAt(99), 0);
      expect(scale.indexAt(100), 1);
      expect(scale.indexAt(399), 3);
      expect(scale.indexAt(900), 3);
    });
  });

  group('paddedDomain', () {
    test('adds breathing room around the data', () {
      final d = paddedDomain([100, 200]);
      expect(d.min, lessThan(100));
      expect(d.max, greaterThan(200));
    });

    test('a flat series still gets a range', () {
      final d = paddedDomain([50, 50, 50]);
      expect(d.max, greaterThan(d.min));
      expect(paddedDomain([0, 0]).max, greaterThan(0));
    });

    test('ignores non-finite values, and copes with none', () {
      final d = paddedDomain([double.nan, 10, double.infinity, 20]);
      expect(d.min, lessThan(10));
      expect(d.max, lessThan(30));
      expect(paddedDomain(const []), (min: 0.0, max: 1.0));
    });
  });

  group('niceTicks', () {
    test('lands on round numbers inside the range', () {
      expect(niceTicks(2413.7, 2561.2), [2450, 2500, 2550]);
      expect(niceTicks(0, 100), [0, 20, 40, 60, 80, 100]);
    });

    test('handles small and negative ranges without drift', () {
      expect(niceTicks(-1.3, 1.3), [-1, -0.5, 0, 0.5, 1]);
      expect(niceTicks(0.1, 0.4), [0.1, 0.2, 0.3, 0.4]);
    });

    test('an empty range has no ticks', () {
      expect(niceTicks(5, 5), isEmpty);
    });
  });

  test('labelIndices spreads labels and keeps both ends', () {
    expect(labelIndices(100), [0, 33, 66, 99]);
    expect(labelIndices(3), [0, 1, 2]);
    expect(labelIndices(0), isEmpty);
  });
}
