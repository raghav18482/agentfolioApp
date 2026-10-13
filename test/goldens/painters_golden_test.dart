// Pixel tests for the hand-drawn graphics: the logo, the treemap, the ring
// gauge and the time-series chart. A change to any painter shows up here as
// an image diff to look at, not a silent regression.
//
// Text renders in the test font (blocks), so these pin shapes and colours,
// not typography. Regenerate after a deliberate change with:
//   flutter test --update-goldens test/goldens
@Tags(['golden'])
library;

import 'package:agentfolio/core/presentation/charts/ring_gauge.dart';
import 'package:agentfolio/core/presentation/charts/time_series_chart.dart';
import 'package:agentfolio/core/presentation/charts/treemap.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/brand/brand_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> shoot(
    WidgetTester tester,
    Widget child,
    String name, {
    Size size = const Size(360, 260),
  }) async {
    tester.view
      ..physicalSize = size * 2
      ..devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        home: Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: RepaintBoundary(key: const Key('shot'), child: child),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(find.byKey(const Key('shot')), matchesGoldenFile('goldens/$name.png'));
  }

  testWidgets('logo, fully drawn', (tester) async {
    await shoot(tester, const BrandMark(size: 160), 'logo');
  });

  testWidgets('treemap of gains and losses', (tester) async {
    await shoot(
      tester,
      SizedBox(
        width: 340,
        child: Treemap(
          height: 220,
          semanticLabel: 'P&L heatmap',
          onTap: (_) {},
          tiles: const [
            TreemapTile(label: 'HDFCGOLD', value: 48, color: AppColors.gain, caption: '+26.1%'),
            TreemapTile(label: 'SML250', value: 14, color: AppColors.gain, caption: '+12.4%'),
            TreemapTile(label: 'MID150', value: 10, color: AppColors.gain, caption: '+7.3%'),
            TreemapTile(label: 'CPSE', value: 9, color: AppColors.loss, caption: '-4.7%'),
            TreemapTile(label: 'NSE', value: 6, color: AppColors.loss, caption: '-3.1%'),
            TreemapTile(label: 'PSUB', value: 3, color: AppColors.loss),
          ],
        ),
      ),
      'treemap',
    );
  });

  testWidgets('ring gauge', (tester) async {
    await shoot(
      tester,
      const RingGauge(
        semanticLabel: 'Cash 30%',
        size: 180,
        parts: [(value: 70, color: AppColors.indigo), (value: 30, color: AppColors.emerald)],
        center: SizedBox.shrink(),
      ),
      'ring_gauge',
    );
  });

  testWidgets('candles with a reference line and volume', (tester) async {
    final start = DateTime(2026, 7);
    final closes = [for (var i = 0; i < 40; i++) 100 + 8 * ((i % 9) - 4) / 4 + i * 0.4];
    await shoot(
      tester,
      SizedBox(
        width: 340,
        child: TimeSeriesChart(
          dates: [for (var i = 0; i < 40; i++) start.add(Duration(days: i))],
          volumes: [for (var i = 0; i < 40; i++) 1000.0 + (i % 5) * 300],
          layers: [
            CandleLayer([
              for (var i = 0; i < 40; i++)
                (
                  open: i == 0 ? closes[0] : closes[i - 1],
                  high: closes[i] + 2,
                  low: closes[i] - 2,
                  close: closes[i],
                ),
            ]),
          ],
          references: const [ReferenceLine(108, color: AppColors.warning, label: 'Avg 108')],
          formatValue: (v) => v.toStringAsFixed(0),
          semanticLabel: 'chart',
        ),
      ),
      'candles',
    );
  });
}
