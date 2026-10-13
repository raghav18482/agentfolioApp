import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/charts/time_series_chart.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/logic/price_history_logic.dart';
import 'package:agentfolio/features/research/presentation/research_style.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/tab_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// Signals, the year's price against its moving averages, RSI, MACD and
/// pivot levels. Same request as the Overview chart, so this tab costs
/// nothing extra.
class TechnicalsTab extends StatelessWidget {
  const TechnicalsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<StockDetailViewModel>();
    final state = context.select<StockDetailViewModel, ViewState<Technicals>>(
      (vm) => vm.technicals.state,
    );
    return switch (state) {
      ViewData(:final data) => _Content(data: data),
      _ => AppCard(
        child: SectionState(
          state: state,
          retryTrackId: 'technicals_retry',
          onRetry: () => unawaited(vm.technicals.load(force: true)),
          skeletonHeight: 420,
          builder: (_, _) => const SizedBox.shrink(),
        ),
      ),
    };
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.data});

  final Technicals data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final h = data.history;
    final enough = h.length >= 2;
    final price = context.select<StockDetailViewModel, double>(
      (vm) => vm.lastPrice ?? data.currentPrice,
    );

    return TabLayout(
      children: [
        (Pane.side, _SignalsCard(signals: data.signals)),
        if (enough)
          (
            Pane.main,
            _IndicatorChartCard(
              title: l10n.dmaChartTitle,
              legend: [
                (l10n.legendPrice, AppColors.textPrimary),
                (l10n.stockDma50, AppColors.info),
                (l10n.stockDma200, AppColors.orange),
              ],
              dates: h.dates,
              height: 220,
              readout: (i) => [
                (l10n.legendPrice, Fmt.money(h.bars[i].close)),
                (l10n.stockDma50, Fmt.money(h.sma50[i])),
                (l10n.stockDma200, Fmt.money(h.sma200[i])),
              ],
              layers: [
                LineLayer(h.closes, color: AppColors.textPrimary, width: 1.6),
                LineLayer(h.sma50, color: AppColors.info, width: 1.4),
                LineLayer(h.sma200, color: AppColors.orange, width: 1.4),
              ],
              semanticLabel: l10n.dmaChartSemantics,
            ),
          ),
        if (enough && h.rsi.any((v) => v != null))
          (
            Pane.main,
            _IndicatorChartCard(
              title: l10n.rsiTitle,
              subtitle: l10n.rsiSubtitle,
              dates: h.dates,
              height: 150,
              readout: (i) => [(l10n.rsiTitle, h.rsi[i]?.toStringAsFixed(1) ?? Fmt.missing)],
              layers: [LineLayer(h.rsi, color: AppColors.brandSoft, width: 1.6)],
              domain: (min: 0, max: 100),
              bands: [ShadedBand(30, 70, color: AppColors.brandSoft.withValues(alpha: 0.06))],
              references: const [
                ReferenceLine(70, color: AppColors.orange),
                ReferenceLine(30, color: AppColors.info),
              ],
              semanticLabel: l10n.rsiSemantics(
                data.indicators.rsi?.toStringAsFixed(1) ?? Fmt.missing,
              ),
            ),
          ),
        if (enough && h.macd.any((v) => v != null))
          (
            Pane.main,
            _IndicatorChartCard(
              title: l10n.macdTitle,
              subtitle: l10n.macdSubtitle,
              legend: [(l10n.legendMacd, AppColors.info), (l10n.legendSignal, AppColors.orange)],
              dates: h.dates,
              height: 160,
              readout: (i) => [
                (l10n.legendMacd, h.macd[i]?.toStringAsFixed(2) ?? Fmt.missing),
                (l10n.legendSignal, h.macdSignal[i]?.toStringAsFixed(2) ?? Fmt.missing),
              ],
              layers: [
                // Bars first, so both lines read on top of them.
                HistogramLayer(h.macdHistogram),
                LineLayer(h.macd, color: AppColors.info, width: 1.5),
                LineLayer(h.macdSignal, color: AppColors.orange, width: 1.5),
              ],
              references: const [ReferenceLine(0, color: AppColors.textMuted, dashed: false)],
              semanticLabel: l10n.macdSemantics,
            ),
          ),
        (Pane.side, _LevelsCard(levels: data.levels, price: price)),
        (Pane.side, _IndicatorsCard(indicators: data.indicators)),
      ],
    );
  }
}

/// How the signals split, as one bar, then each one with its reading.
class _SignalsCard extends StatelessWidget {
  const _SignalsCard({required this.signals});

  final List<TechnicalSignal> signals;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tally = tallySignals(signals);
    return SectionCard(
      title: l10n.signalsTitle,
      child: signals.isEmpty
          ? Text(l10n.signalsEmpty, style: context.text.bodySmall)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  label: l10n.signalsTally(tally.bullish, tally.bearish, tally.neutral),
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          height: 8,
                          child: Row(
                            children: [
                              if (tally.bullish > 0)
                                Expanded(
                                  flex: tally.bullish,
                                  child: Container(color: AppColors.gain),
                                ),
                              if (tally.neutral > 0)
                                Expanded(
                                  flex: tally.neutral,
                                  child: Container(color: AppColors.textMuted),
                                ),
                              if (tally.bearish > 0)
                                Expanded(
                                  flex: tally.bearish,
                                  child: Container(color: AppColors.loss),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpace.sm),
                      Text(
                        l10n.signalsTally(tally.bullish, tally.bearish, tally.neutral),
                        style: context.text.labelMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpace.md),
                for (final s in signals) _SignalRow(signal: s),
              ],
            ),
    );
  }
}

class _SignalRow extends StatelessWidget {
  const _SignalRow({required this.signal});

  final TechnicalSignal signal;

  @override
  Widget build(BuildContext context) {
    final color = ResearchStyle.signal(signal.status);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Icon(
              ResearchStyle.signalIcon(signal.status),
              color: color,
              size: signal.status == SignalStatus.neutral ? 8 : 24,
              semanticLabel: signal.status.name,
            ),
          ),
          const SizedBox(width: AppSpace.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(signal.name, style: context.text.titleSmall),
                Text(signal.value, style: context.text.labelMedium?.tabular),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          Flexible(
            child: Text(
              signal.label,
              textAlign: TextAlign.end,
              style: context.text.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// An indicator chart with a legend that becomes the scrubbed day's values.
class _IndicatorChartCard extends StatefulWidget {
  const _IndicatorChartCard({
    required this.title,
    required this.dates,
    required this.layers,
    required this.readout,
    required this.semanticLabel,
    required this.height,
    this.subtitle,
    this.legend = const [],
    this.references = const [],
    this.bands = const [],
    this.domain,
  });

  final String title;
  final String? subtitle;
  final List<(String, Color)> legend;
  final List<DateTime> dates;
  final List<SeriesLayer> layers;
  final List<(String, String)> Function(int index) readout;
  final List<ReferenceLine> references;
  final List<ShadedBand> bands;
  final ({double min, double max})? domain;
  final String semanticLabel;
  final double height;

  @override
  State<_IndicatorChartCard> createState() => _IndicatorChartCardState();
}

class _IndicatorChartCardState extends State<_IndicatorChartCard> {
  int? _scrub;

  @override
  Widget build(BuildContext context) {
    final i = _scrub;
    final muted = context.text.labelMedium;
    return SectionCard(
      title: widget.title,
      subtitle: widget.subtitle,
      padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.lg, AppSpace.sm, AppSpace.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
            child: i == null
                ? Wrap(
                    spacing: AppSpace.lg,
                    children: [
                      for (final (label, color) in widget.legend)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(width: 12, height: 3, color: color),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(label, style: muted, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                    ],
                  )
                : Row(
                    children: [
                      Text(DateFormat('d MMM yy').format(widget.dates[i]), style: muted),
                      const SizedBox(width: AppSpace.md),
                      // Three values on a phone: shrink a touch rather than spill.
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                for (final (label, value) in widget.readout(i)) ...[
                                  const SizedBox(width: AppSpace.md),
                                  Text(
                                    '$label $value',
                                    style: muted?.tabular.copyWith(color: AppColors.textPrimary),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpace.sm),
                    ],
                  ),
          ),
          const SizedBox(height: AppSpace.sm),
          TimeSeriesChart(
            height: widget.height,
            dates: widget.dates,
            layers: widget.layers,
            references: widget.references,
            bands: widget.bands,
            domain: widget.domain,
            formatValue: Fmt.axis,
            onScrub: (index) => setState(() => _scrub = index),
            semanticLabel: widget.semanticLabel,
          ),
        ],
      ),
    );
  }
}

/// Pivot levels as a ladder, highest first, with "Now" slotted in where the
/// price is, so which levels sit above and below reads at a glance.
class _LevelsCard extends StatelessWidget {
  const _LevelsCard({required this.levels, required this.price});

  final PivotLevels levels;
  final double price;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.levelsTitle,
      subtitle: l10n.levelsSubtitle,
      child: !levels.isAvailable
          ? Text(l10n.levelsEmpty, style: context.text.bodySmall)
          : Column(
              children: [
                for (final rung in pivotLadder(levels, price))
                  switch (rung) {
                    LevelRung(:final level) => _LevelRow(
                      label: switch (level) {
                        PivotLevel.r2 => 'R2',
                        PivotLevel.r1 => 'R1',
                        PivotLevel.pivot => l10n.levelPivot,
                        PivotLevel.s1 => 'S1',
                        PivotLevel.s2 => 'S2',
                      },
                      price: rung.price,
                      color: switch (level) {
                        PivotLevel.r1 || PivotLevel.r2 => AppColors.gain,
                        PivotLevel.pivot => AppColors.brandSoft,
                        PivotLevel.s1 || PivotLevel.s2 => AppColors.loss,
                      },
                      distance: (rung.price - price) / price * 100,
                    ),
                    CurrentRung() => _NowRow(price: rung.price),
                  },
              ],
            ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  const _LevelRow({
    required this.label,
    required this.price,
    required this.color,
    required this.distance,
  });

  final String label;
  final double price;
  final Color color;

  /// Percent away from the current price.
  final double distance;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 44),
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(label, style: context.text.labelMedium?.copyWith(color: color)),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(child: Text(Fmt.money(price), style: context.text.titleSmall?.tabular)),
        Text(
          Fmt.signedPct(distance),
          style: context.text.labelMedium?.tabular.copyWith(color: AppColors.textMuted),
        ),
      ],
    ),
  );
}

class _NowRow extends StatelessWidget {
  const _NowRow({required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 44),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              l10n.levelsNow,
              style: context.text.labelMedium?.copyWith(color: AppColors.background),
            ),
          ),
          const SizedBox(width: AppSpace.md),
          Flexible(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(Fmt.money(price), style: context.text.titleSmall?.tabular),
            ),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(child: Divider(color: context.palette.neutral.withValues(alpha: 0.4))),
        ],
      ),
    );
  }
}

class _IndicatorsCard extends StatelessWidget {
  const _IndicatorsCard({required this.indicators});

  final TechnicalIndicators indicators;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final i = indicators;
    final rows = [
      (l10n.stockDma50, Fmt.money(i.sma50)),
      (l10n.stockDma200, Fmt.money(i.sma200)),
      (l10n.stockRsi, i.rsi?.toStringAsFixed(1) ?? Fmt.missing),
      (l10n.legendMacd, i.macd?.toStringAsFixed(2) ?? Fmt.missing),
      (l10n.legendSignal, i.macdSignal?.toStringAsFixed(2) ?? Fmt.missing),
      (l10n.stock52wHigh, Fmt.money(i.week52High)),
      (l10n.stock52wLow, Fmt.money(i.week52Low)),
      (l10n.stockVolumeRatio, Fmt.multiple(i.volumeRatio)),
    ];
    return SectionCard(
      title: l10n.indicatorsTitle,
      child: Column(
        children: [
          for (final (label, value) in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: context.text.bodyMedium?.copyWith(color: context.palette.neutral),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: context.text.titleSmall?.tabular,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
