import 'dart:math' as math;

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/charts/chart_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Annual revenue and net profit side by side per year. Grouped bars rather
/// than the web's bar-plus-line: two bars per year read better on a phone
/// and a loss year shows plainly below zero.
class TrendCard extends StatelessWidget {
  const TrendCard({required this.revenue, required this.profit, super.key});

  final List<TrendPoint> revenue;
  final List<TrendPoint> profit;

  static const Color _revenueColor = AppColors.brandSoft;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final years = <String>{for (final p in revenue) p.year, for (final p in profit) p.year}.toList()
      ..sort();
    final rev = {for (final p in revenue) p.year: p.value};
    final pro = {for (final p in profit) p.year: p.value};

    return SectionCard(
      title: l10n.trendTitle,
      subtitle: l10n.trendSubtitle,
      child: years.isEmpty
          ? Text(l10n.trendEmpty, style: context.text.bodySmall)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: AppSpace.lg,
                  children: [
                    _Legend(color: _revenueColor, label: l10n.trendRevenue),
                    _Legend(color: AppColors.gain, label: l10n.trendProfit),
                  ],
                ),
                const SizedBox(height: AppSpace.lg),
                SizedBox(
                  height: 200,
                  child: Semantics(
                    label: l10n.trendSemantics(years.first, years.last),
                    child: _Chart(years: years, revenue: rev, profit: pro),
                  ),
                ),
              ],
            ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.years, required this.revenue, required this.profit});

  final List<String> years;
  final Map<String, double> revenue;
  final Map<String, double> profit;

  @override
  Widget build(BuildContext context) {
    final values = [...revenue.values, ...profit.values];
    final maxY = math.max(0, values.reduce(math.max)).toDouble();
    final minY = math.min(0, values.reduce(math.min)).toDouble();
    final labelStyle = context.text.labelSmall?.copyWith(
      letterSpacing: 0,
      color: AppColors.textMuted,
      fontFeatures: AppTypography.tabular,
    );

    BarChartRodData rod(double? v, Color color) => BarChartRodData(
      toY: v ?? 0,
      color: (v ?? 0) < 0 ? AppColors.loss : color,
      width: 12,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular((v ?? 0) >= 0 ? 4 : 0),
        bottom: Radius.circular((v ?? 0) < 0 ? 4 : 0),
      ),
    );

    return BarChart(
      BarChartData(
        maxY: maxY * 1.1,
        minY: minY * 1.1,
        alignment: BarChartAlignment.spaceAround,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => const FlLine(color: ChartPalette.grid, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 64,
              getTitlesWidget: (value, meta) => value == meta.max || value == meta.min
                  ? const SizedBox.shrink()
                  : SideTitleWidget(
                      meta: meta,
                      child: Text(Fmt.crores(value), style: labelStyle),
                    ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: Text(years[value.toInt()], style: labelStyle),
              ),
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.surfaceHighest,
            getTooltipItem: (group, _, rod, rodIndex) => BarTooltipItem(
              Fmt.crores(rod.toY),
              context.text.labelMedium!.tabular.copyWith(
                color: rodIndex == 0 ? TrendCard._revenueColor : context.palette.pnl(rod.toY),
              ),
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < years.length; i++)
            BarChartGroupData(
              x: i,
              barsSpace: 4,
              barRods: [
                rod(revenue[years[i]], TrendCard._revenueColor),
                rod(profit[years[i]], AppColors.gain),
              ],
            ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      ),
      const SizedBox(width: 6),
      Text(label, style: context.text.labelMedium),
    ],
  );
}
