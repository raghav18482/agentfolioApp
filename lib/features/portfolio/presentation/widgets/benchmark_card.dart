import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/charts/chart_palette.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/info_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// The portfolio's cumulative return against NIFTY 50, with beta, alpha and
/// R². The server fetches history per holding, so this loads only once the
/// card scrolls into view.
class BenchmarkCard extends StatelessWidget {
  const BenchmarkCard({required this.benchmark, required this.onVisible, super.key});

  final Loadable<BenchmarkComparison> benchmark;
  final VoidCallback onVisible;

  static const days = 90;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return VisibilityDetector(
      key: const ValueKey('benchmark_card'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15) onVisible();
      },
      child: SectionCard(
        title: l10n.benchmarkTitle,
        subtitle: l10n.benchmarkSubtitle(days),
        child: switch (benchmark.state) {
          // Not scrolled into view yet: a still placeholder. Shimmering here
          // would animate off-screen for nothing.
          ViewIdle() => const SkeletonBox(width: double.infinity, height: 260),
          ViewLoading() => const Shimmer(child: SkeletonBox(width: double.infinity, height: 260)),
          ViewError(:final failure) => AppAlert(
            message: failure.message,
            action: AppButton(
              trackId: 'benchmark_retry',
              label: l10n.commonRetry,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              onPressed: () => unawaited(benchmark.load(force: true)),
            ),
          ),
          ViewData(:final data) when data.dates.length < 2 => Text(
            l10n.benchmarkNotEnoughData,
            style: context.text.bodySmall,
          ),
          ViewData(:final data) => _Content(data: data),
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.data});

  final BenchmarkComparison data;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const _Legend(),
      const SizedBox(height: AppSpace.md),
      SizedBox(height: 200, child: _Chart(data: data)),
      const SizedBox(height: AppSpace.lg),
      Divider(color: context.palette.border, height: 1),
      const SizedBox(height: AppSpace.lg),
      _Stats(data: data),
      if (data.stockBetas.isNotEmpty) ...[
        const SizedBox(height: AppSpace.lg),
        Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            for (final s in data.stockBetas)
              StatusChip(
                '${Fmt.symbol(s.symbol)}  ${s.beta.toStringAsFixed(2)}',
                color: _bandColor(context, BetaBand.of(s.beta)),
              ),
          ],
        ),
      ],
    ],
  );
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget item(Color color, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 3, color: color),
        const SizedBox(width: 6),
        Text(label, style: context.text.labelMedium),
      ],
    );
    return Wrap(
      spacing: AppSpace.lg,
      children: [
        item(ChartPalette.portfolio, l10n.benchmarkPortfolio),
        item(ChartPalette.nifty, l10n.benchmarkNifty),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.data});

  final BenchmarkComparison data;

  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat('d MMM');
    List<FlSpot> spots(List<double> values) => [
      for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
    ];
    LineChartBarData line(List<double> values, Color color, {bool fill = false}) =>
        LineChartBarData(
          spots: spots(values),
          color: color,
          barWidth: 2.2,
          isCurved: true,
          curveSmoothness: 0.15,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: fill,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
            ),
          ),
        );
    final last = (data.dates.length - 1).toDouble();
    final labelStyle = context.text.labelSmall?.copyWith(
      letterSpacing: 0,
      color: AppColors.textMuted,
    );

    return Semantics(
      label: AppLocalizations.of(context).benchmarkSemantics(
        Fmt.signedPct(data.portfolioCumulative.last),
        Fmt.signedPct(data.niftyCumulative.last),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: last,
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => const FlLine(color: ChartPalette.grid, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text('${value.toStringAsFixed(0)}%', style: labelStyle),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                interval: (last / 3).clamp(1, double.infinity),
                getTitlesWidget: (value, meta) {
                  final i = value.round();
                  if (i < 0 || i >= data.dates.length) return const SizedBox.shrink();
                  return SideTitleWidget(
                    meta: meta,
                    // Keeps the first and last dates from running off the edge.
                    fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
                    child: Text(dateLabel.format(data.dates[i]), style: labelStyle),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppColors.surfaceHighest,
              getTooltipItems: (spots) => [
                for (final s in spots)
                  LineTooltipItem(
                    '${s.barIndex == 0 ? '${dateLabel.format(data.dates[s.x.round()])}\n' : ''}'
                    '${Fmt.signedPct(s.y)}',
                    context.text.labelMedium!.tabular.copyWith(color: s.bar.color),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            line(data.portfolioCumulative, ChartPalette.portfolio, fill: true),
            line(data.niftyCumulative, ChartPalette.nifty),
          ],
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.data});

  final BenchmarkComparison data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final band = BetaBand.of(data.beta);
    return Wrap(
      spacing: AppSpace.xl,
      runSpacing: AppSpace.lg,
      children: [
        _Stat(
          label: l10n.benchmarkBeta,
          value: data.beta.toStringAsFixed(3),
          caption: switch (band) {
            BetaBand.aggressive => l10n.benchmarkBandAggressive,
            BetaBand.market => l10n.benchmarkBandMarket,
            BetaBand.defensive => l10n.benchmarkBandDefensive,
          },
          color: _bandColor(context, band),
          onInfo: () => showInfoSheet(
            context,
            title: l10n.benchmarkBetaInfoTitle,
            body: l10n.benchmarkBetaInfoBody,
            sections: [
              (heading: l10n.infoIdeal, body: l10n.benchmarkBetaInfoIdeal),
              (heading: l10n.infoTip, body: l10n.benchmarkBetaInfoTip),
            ],
          ),
        ),
        _Stat(
          label: l10n.benchmarkAlpha,
          value: '${(data.alpha * 100).toStringAsFixed(4)}%',
          onInfo: () => showInfoSheet(
            context,
            title: l10n.benchmarkAlphaInfoTitle,
            body: l10n.benchmarkAlphaInfoBody,
            sections: [
              (heading: l10n.infoIdeal, body: l10n.benchmarkAlphaInfoIdeal),
              (heading: l10n.infoTip, body: l10n.benchmarkAlphaInfoTip),
            ],
          ),
        ),
        _Stat(
          label: l10n.benchmarkRSquared,
          value: data.rSquared.toStringAsFixed(3),
          onInfo: () => showInfoSheet(
            context,
            title: l10n.benchmarkR2InfoTitle,
            body: l10n.benchmarkR2InfoBody,
            sections: [
              (heading: l10n.infoIdeal, body: l10n.benchmarkR2InfoIdeal),
              (heading: l10n.infoTip, body: l10n.benchmarkR2InfoTip),
            ],
          ),
        ),
        _Stat(label: l10n.benchmarkDays, value: data.daysUsed == 0 ? '—' : '${data.daysUsed}'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, this.caption, this.color, this.onInfo});

  final String label;
  final String value;
  final String? caption;
  final Color? color;
  final VoidCallback? onInfo;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onInfo == null
        ? null
        : () {
            context.trackTap('benchmark_info_${label.toLowerCase()}');
            onInfo!();
          },
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label.toUpperCase(), style: context.text.labelSmall),
              if (onInfo != null) ...[
                const SizedBox(width: 4),
                const Icon(Icons.info_outline_rounded, size: 13, color: AppColors.textMuted),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: context.text.titleLarge?.tabular.copyWith(color: color ?? AppColors.textPrimary),
          ),
          if (caption != null)
            Text(caption!, style: context.text.labelMedium?.copyWith(color: color)),
        ],
      ),
    ),
  );
}

Color _bandColor(BuildContext context, BetaBand band) => switch (band) {
  BetaBand.aggressive => context.palette.loss,
  BetaBand.market => context.palette.warning,
  BetaBand.defensive => context.palette.gain,
};
