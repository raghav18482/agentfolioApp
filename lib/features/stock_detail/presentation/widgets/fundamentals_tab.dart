import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/logic/research_logic.dart';
import 'package:agentfolio/features/research/presentation/widgets/metric_sheet.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/score_card.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/tab_layout.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/trend_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The score, the ratios behind it and the revenue/profit trend. Loaded the
/// first time this tab is shown: Yahoo is slow, and many visits never get
/// here.
class FundamentalsTab extends StatelessWidget {
  const FundamentalsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<StockDetailViewModel>();
    final state = context.select<StockDetailViewModel, ViewState<Fundamentals>>(
      (vm) => vm.fundamentals.state,
    );

    // Not a card per section until data arrives: one state for the tab, so a
    // failure shows once rather than in four cards.
    return switch (state) {
      ViewData(:final data) => _Content(data: data),
      _ => AppCard(
        child: SectionState(
          state: state,
          retryTrackId: 'fundamentals_retry',
          unavailableHint: AppLocalizations.of(context).fundamentalsUnavailableHint,
          onRetry: () => unawaited(vm.fundamentals.load(force: true)),
          skeleton: const _Skeleton(),
          builder: (_, _) => const SizedBox.shrink(),
        ),
      ),
    };
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.data});

  final Fundamentals data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final verdicts = verdictsByKey(data.score);
    final v = data.valuation;
    final h = data.health;
    String pct(double? x) => Fmt.percent(x);

    return TabLayout(
      children: [
        (Pane.main, ScoreCard(score: data.score, sector: data.sector, industry: data.industry)),
        (
          Pane.side,
          _MetricsCard(
            title: l10n.valuationTitle,
            subtitle: l10n.metricsHint,
            verdicts: verdicts,
            rows: [
              _MetricRow(
                'pe_ratio',
                l10n.metricPe,
                Fmt.multiple(v.peRatio),
                sub: v.forwardPe == null ? null : l10n.metricForward(Fmt.number(v.forwardPe)),
              ),
              _MetricRow('pb_ratio', l10n.metricPb, Fmt.multiple(v.pbRatio)),
              _MetricRow('ev_ebitda', l10n.metricEvEbitda, Fmt.multiple(v.evEbitda)),
              _MetricRow('peg_ratio', l10n.metricPeg, Fmt.number(v.pegRatio)),
              _MetricRow('dividend_yield', l10n.metricDividendYield, pct(v.dividendYield)),
              _MetricRow('trailing_eps', l10n.metricEps, Fmt.money(v.trailingEps)),
            ],
          ),
        ),
        (
          Pane.side,
          _MetricsCard(
            title: l10n.healthTitle,
            verdicts: verdicts,
            rows: [
              _MetricRow('roe', l10n.metricRoe, pct(h.roe)),
              _MetricRow('roce', l10n.metricRoce, pct(h.roce)),
              _MetricRow('debt_to_equity', l10n.metricDebtToEquity, Fmt.number(h.debtToEquity)),
              _MetricRow('free_cash_flow', l10n.metricFreeCashFlow, Fmt.crores(h.freeCashFlow)),
              _MetricRow('profit_margin', l10n.metricProfitMargin, pct(h.profitMargin)),
              _MetricRow('operating_margin', l10n.metricOperatingMargin, pct(h.operatingMargin)),
              _MetricRow('revenue_growth', l10n.metricRevenueGrowth, pct(h.revenueGrowth)),
              _MetricRow('earnings_growth', l10n.metricEarningsGrowth, pct(h.earningsGrowth)),
              _MetricRow('promoter_holding', l10n.metricPromoterHolding, pct(h.promoterHolding)),
            ],
          ),
        ),
        (Pane.main, TrendCard(revenue: data.revenueTrend, profit: data.profitTrend)),
      ],
    );
  }
}

class _MetricRow {
  const _MetricRow(this.key, this.label, this.value, {this.sub});

  /// Matches a glossary entry and a score metric.
  final String key;
  final String label;
  final String value;
  final String? sub;
}

/// A list of ratios. Each row opens what the metric means, its ideal range
/// and this stock's reading: the whole row is the target, not a tiny ⓘ.
class _MetricsCard extends StatelessWidget {
  const _MetricsCard({
    required this.title,
    required this.rows,
    required this.verdicts,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<_MetricRow> rows;
  final Map<String, ScoreMetric> verdicts;

  @override
  Widget build(BuildContext context) => SectionCard(
    title: title,
    subtitle: subtitle,
    padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.lg, AppSpace.lg, AppSpace.sm),
    child: Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) Divider(height: 1, color: context.palette.border),
          _Row(row: rows[i], reading: verdicts[rows[i].key]),
        ],
      ],
    ),
  );
}

class _Row extends StatelessWidget {
  const _Row({required this.row, required this.reading});

  final _MetricRow row;
  final ScoreMetric? reading;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<StockDetailViewModel>();
    return InkWell(
      onTap: () {
        context.trackTap('metric_info_${row.key}');
        unawaited(
          showMetricSheet(
            context,
            fallbackTitle: row.label,
            metric: vm.glossary.data?.metrics[row.key],
            reading: reading,
            onOpenGuide: () => unawaited(context.push(Routes.learnAt(row.key))),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
        child: Row(
          children: [
            SizedBox(width: 16, child: reading == null ? null : VerdictDot(reading!.verdict)),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      row.label,
                      style: context.text.bodyMedium?.copyWith(color: context.palette.neutral),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(row.value, style: context.text.titleSmall?.tabular),
                if (row.sub != null)
                  Text(row.sub!, style: context.text.labelSmall?.copyWith(letterSpacing: 0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SkeletonBox(width: 160, height: 18),
      SizedBox(height: AppSpace.lg),
      Row(
        children: [
          SkeletonBox(width: 104, height: 104, radius: Radius.circular(52)),
          SizedBox(width: AppSpace.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 90, height: 24),
                SizedBox(height: AppSpace.sm),
                SkeletonBox(width: double.infinity, height: 40),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: AppSpace.xl),
      SkeletonBox(width: double.infinity, height: 200),
    ],
  );
}
