import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/charts/time_series_chart.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/logic/price_history_logic.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// The price over a chosen range, as a line or candles, with volume and the
/// user's average buy price. Drag across it to read any day; the readout
/// replaces the range's return at the top while the finger is down.
class PriceChartCard extends StatefulWidget {
  const PriceChartCard({super.key});

  static const chartHeight = 260.0;

  @override
  State<PriceChartCard> createState() => _PriceChartCardState();
}

class _PriceChartCardState extends State<PriceChartCard> {
  int? _scrub;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<StockDetailViewModel>();
    final state = context.select<StockDetailViewModel, ViewState<Technicals>>(
      (vm) => vm.technicals.state,
    );
    final range = context.select<StockDetailViewModel, ChartRange>((vm) => vm.range);
    final candles = context.select<StockDetailViewModel, bool>((vm) => vm.showCandles);
    final average = context.select<StockDetailViewModel, double?>((vm) => vm.holding?.averagePrice);

    return AppCard(
      padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.lg, AppSpace.sm, AppSpace.md),
      child: SectionState(
        state: state,
        retryTrackId: 'stock_chart_retry',
        onRetry: () => unawaited(vm.technicals.load(force: true)),
        skeletonHeight: PriceChartCard.chartHeight + 90,
        builder: (context, data) {
          final history = data.history;
          if (history.length < 2) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.xl),
              child: Text(l10n.chartNotEnough, style: context.text.bodySmall),
            );
          }
          final window = _Window.of(history, range);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpace.sm),
                child: _Readout(window: window, scrub: _scrub, candles: candles, range: range),
              ),
              const SizedBox(height: AppSpace.md),
              TimeSeriesChart(
                // A new key replays the draw-in when the range or style changes.
                key: ValueKey('${range.name}_$candles'),
                height: PriceChartCard.chartHeight,
                dates: window.dates,
                volumes: window.volumes,
                layers: [
                  if (candles)
                    CandleLayer([
                      for (final b in window.bars)
                        (open: b.open, high: b.high, low: b.low, close: b.close),
                    ])
                  else
                    LineLayer(
                      window.closes,
                      color: context.palette.pnl(window.change?.amount),
                      width: 2,
                      fill: true,
                    ),
                ],
                references: [
                  if (average != null && average > 0)
                    ReferenceLine(
                      average,
                      color: AppColors.warning,
                      label: l10n.stockAvgLabel(Fmt.axis(average)),
                      keepInView: true,
                    ),
                ],
                formatValue: Fmt.axis,
                onScrub: (i) => setState(() => _scrub = i),
                semanticLabel: l10n.stockChartSemantics(
                  Fmt.symbol(vm.symbol),
                  _rangeLabel(l10n, range),
                  Fmt.signedPct(window.change?.percent),
                ),
              ),
              const SizedBox(height: AppSpace.md),
              Padding(
                padding: const EdgeInsets.only(right: AppSpace.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: AppSegmented<ChartRange>(
                        trackId: 'stock_chart_range',
                        selected: range,
                        onChanged: vm.setRange,
                        segments: [
                          for (final r in ChartRange.values)
                            AppSegment(value: r, label: _rangeLabel(l10n, r), id: r.name),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpace.xs),
                    AppIconButton(
                      trackId: candles ? 'stock_chart_line' : 'stock_chart_candles',
                      icon: candles ? Icons.show_chart_rounded : Icons.candlestick_chart_outlined,
                      tooltip: candles ? l10n.stockChartLine : l10n.stockChartCandles,
                      color: AppColors.textSecondary,
                      onPressed: () => vm.setCandles(candles: !candles),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _rangeLabel(AppLocalizations l10n, ChartRange r) => switch (r) {
  ChartRange.month => l10n.stockRange1M,
  ChartRange.quarter => l10n.stockRange3M,
  ChartRange.half => l10n.stockRange6M,
  ChartRange.year => l10n.stockRange1Y,
};

/// The slice of history inside the chosen range.
class _Window {
  _Window(this.dates, this.bars, this.volumes);

  factory _Window.of(PriceHistory h, ChartRange range) {
    final start = rangeStart(h.dates, range);
    return _Window(h.dates.sublist(start), h.bars.sublist(start), h.volumes.sublist(start));
  }

  final List<DateTime> dates;
  final List<Ohlc> bars;
  final List<double> volumes;

  late final List<double> closes = [for (final b in bars) b.close];

  /// From the first close in range to the last.
  late final PriceChange? change = changeBetween(bars.first.close, bars.last.close);
}

/// Above the chart: the range's return, or the scrubbed day's figures.
class _Readout extends StatelessWidget {
  const _Readout({
    required this.window,
    required this.scrub,
    required this.candles,
    required this.range,
  });

  final _Window window;
  final int? scrub;
  final bool candles;
  final ChartRange range;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muted = context.text.labelMedium?.copyWith(color: AppColors.textMuted);
    final i = scrub;

    if (i == null || i >= window.bars.length) {
      final change = window.change;
      return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 40),
        child: Row(
          children: [
            Expanded(child: Text(l10n.stockChartTitle, style: context.text.titleMedium)),
            if (change != null)
              Flexible(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSpace.xs,
                  children: [
                    PnlPercent(change.percent, style: context.text.titleSmall),
                    Text(l10n.stockRangeSuffix(_rangeLabel(l10n, range)), style: muted),
                  ],
                ),
              ),
          ],
        ),
      );
    }

    final bar = window.bars[i];
    final fromStart = changeBetween(window.bars.first.close, bar.close);
    final value = context.text.labelMedium?.tabular.copyWith(color: AppColors.textPrimary);
    return SizedBox(
      height: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat('EEE, d MMM yyyy').format(window.dates[i]),
                  style: muted,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(Fmt.money(bar.close), style: context.text.titleSmall?.tabular),
              if (fromStart != null) ...[
                const SizedBox(width: AppSpace.sm),
                PnlPercent(fromStart.percent, style: context.text.labelMedium, showArrow: false),
              ],
            ],
          ),
          const SizedBox(height: 2),
          if (candles)
            Text(
              l10n.stockOhlc(
                Fmt.axis(bar.open),
                Fmt.axis(bar.high),
                Fmt.axis(bar.low),
                Fmt.axis(bar.close),
              ),
              style: value,
              maxLines: 1,
            )
          else
            Text(l10n.stockVolume(Fmt.number(window.volumes[i])), style: value, maxLines: 1),
        ],
      ),
    );
  }
}
