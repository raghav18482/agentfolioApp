import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/market/market_stream.dart';
import 'package:agentfolio/core/presentation/charts/time_series_chart.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/trading/presentation/view_models/live_watch_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Stands in while nothing is being watched.
final ValueListenable<MarketTick?> _noTicks = ValueNotifier<MarketTick?>(null);

/// One stock's price as it trades, over its last three months.
class LiveWatchCard extends StatelessWidget {
  const LiveWatchCard({super.key});

  static const _days = 66;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LiveWatchViewModel>();
    final symbol = vm.symbol;
    final history = vm.history;

    return SectionCard(
      title: l10n.liveTitle,
      trailing: vm.quote == null ? null : _StreamBadge(status: vm.quote!.status),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Picker(vm: vm),
          const SizedBox(height: AppSpace.lg),
          if (symbol == null)
            Text(
              l10n.liveNoHoldings,
              style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
            )
          else if (history != null)
            SectionState<Technicals>(
              state: history.state,
              retryTrackId: 'live_history_retry',
              onRetry: () => unawaited(history.load(force: true)),
              skeletonHeight: 220,
              unavailableHint: l10n.liveUnavailableHint,
              builder: (context, data) {
                final h = data.history;
                final start = (h.bars.length - _days).clamp(0, h.bars.length);
                final bars = h.bars.sublist(start);
                final lastClose = bars.isEmpty ? null : bars.last.close;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _LivePrice(symbol: symbol, tick: vm.quote?.tick, lastClose: lastClose),
                    const SizedBox(height: AppSpace.md),
                    if (bars.length > 1)
                      _Chart(
                        dates: h.dates.sublist(start),
                        bars: bars,
                        tick: vm.quote?.tick,
                        average: vm.holding?.averagePrice,
                        symbol: Fmt.symbol(symbol),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _Picker extends StatefulWidget {
  const _Picker({required this.vm});

  final LiveWatchViewModel vm;

  @override
  State<_Picker> createState() => _PickerState();
}

class _PickerState extends State<_Picker> {
  final _typed = TextEditingController();

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  void _load() {
    final text = _typed.text.trim();
    if (text.isEmpty) return;
    context.trackTap('live_load_symbol');
    widget.vm.select(text);
    _typed.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final holdings = widget.vm.holdings.data ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (holdings.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: holdings.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpace.sm),
              itemBuilder: (context, i) {
                final h = holdings[i];
                return ChoiceChip(
                  label: Text(Fmt.symbol(h.symbol)),
                  selected: widget.vm.symbol == h.symbol,
                  onSelected: (_) {
                    context.trackChange('live_symbol', 'holding');
                    widget.vm.select(h.symbol);
                  },
                );
              },
            ),
          ),
        const SizedBox(height: AppSpace.sm),
        TextField(
          controller: _typed,
          textCapitalization: TextCapitalization.characters,
          autocorrect: false,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _load(),
          decoration: InputDecoration(
            isDense: true,
            hintText: l10n.liveAnySymbol,
            prefixIcon: const Icon(Icons.search_rounded, size: 20),
            suffixIcon: IconButton(
              tooltip: l10n.liveLoad,
              icon: const Icon(Icons.arrow_forward_rounded),
              onPressed: _load,
            ),
          ),
        ),
      ],
    );
  }
}

/// The big number: live when ticking, the last close otherwise, flashing
/// green or red as it moves.
class _LivePrice extends StatefulWidget {
  const _LivePrice({required this.symbol, required this.tick, required this.lastClose});

  final String symbol;
  final ValueListenable<MarketTick?>? tick;
  final double? lastClose;

  @override
  State<_LivePrice> createState() => _LivePriceState();
}

class _LivePriceState extends State<_LivePrice> {
  double? _previous;
  Color? _flash;
  Timer? _fade;

  @override
  void dispose() {
    _fade?.cancel();
    super.dispose();
  }

  void _flashFor(double price) {
    final previous = _previous;
    _previous = price;
    if (previous == null || previous == price) return;
    _flash = price > previous ? AppColors.gain : AppColors.loss;
    _fade?.cancel();
    _fade = Timer(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _flash = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final listenable = widget.tick ?? _noTicks;
    return ValueListenableBuilder<MarketTick?>(
      valueListenable: listenable,
      builder: (context, tick, _) {
        final price = tick?.price ?? widget.lastClose;
        if (tick != null) _flashFor(tick.price);
        final close = widget.lastClose;
        final change = price == null || close == null || close == 0 ? null : price - close;
        final stale =
            tick != null &&
            Times.isMarketOpen(DateTime.now().toUtc()) &&
            DateTime.now().difference(tick.at) > const Duration(seconds: 30);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Fmt.symbol(widget.symbol),
              style: context.text.labelLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 2),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: AppSpace.md,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: context.text.headlineMedium!.tabular.copyWith(
                    color: _flash ?? AppColors.textPrimary,
                  ),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(price == null ? Fmt.missing : Fmt.money(price)),
                  ),
                ),
                if (change != null && close != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${Fmt.signedMoney(change)} (${Fmt.signedPct(change / close * 100)})',
                      style: context.text.bodyMedium?.copyWith(color: context.palette.pnl(change)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              tick == null
                  ? l10n.liveLastClose
                  // After hours the server repeats the last traded price:
                  // not "live", whatever its timestamp says.
                  : !Times.isMarketOpen(DateTime.now().toUtc())
                  ? l10n.liveAfterHours
                  : stale
                  ? l10n.liveDelayed(Times.relative(tick.at))
                  : l10n.liveTickAt(Times.relative(tick.at)),
              style: context.text.labelMedium?.copyWith(
                color: stale ? AppColors.warning : context.palette.textMuted,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.dates,
    required this.bars,
    required this.tick,
    required this.average,
    required this.symbol,
  });

  final List<DateTime> dates;
  final List<Ohlc> bars;
  final ValueListenable<MarketTick?>? tick;
  final double? average;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ValueListenableBuilder<MarketTick?>(
      valueListenable: tick ?? _noTicks,
      builder: (context, live, _) => TimeSeriesChart(
        dates: dates,
        layers: [
          CandleLayer([
            for (final b in bars) (open: b.open, high: b.high, low: b.low, close: b.close),
          ]),
        ],
        references: [
          if (average != null && average! > 0)
            ReferenceLine(
              average!,
              color: AppColors.warning,
              label: l10n.stockAvgLabel(Fmt.axis(average!)),
            ),
          if (live != null)
            ReferenceLine(
              live.price,
              color: AppColors.brandSoft,
              label: Times.isMarketOpen(DateTime.now().toUtc())
                  ? l10n.liveLineLabel(Fmt.axis(live.price))
                  : l10n.lastLineLabel(Fmt.axis(live.price)),
              keepInView: true,
            ),
        ],
        formatValue: Fmt.axis,
        semanticLabel: l10n.liveChartLabel(symbol),
      ),
    );
  }
}

class _StreamBadge extends StatelessWidget {
  const _StreamBadge({required this.status});

  final ValueListenable<StreamStatus> status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ValueListenableBuilder<StreamStatus>(
      valueListenable: status,
      builder: (context, s, _) {
        final open = Times.isMarketOpen(DateTime.now().toUtc());
        final (label, color) = switch (s.phase) {
          StreamPhase.live when !open => (l10n.liveMarketClosed, AppColors.textMuted),
          StreamPhase.live => (l10n.liveOn, AppColors.gain),
          StreamPhase.connecting || StreamPhase.idle => (l10n.liveConnecting, AppColors.textMuted),
          StreamPhase.reconnecting => (l10n.liveReconnecting, AppColors.warning),
          StreamPhase.paused => (l10n.livePaused, AppColors.textMuted),
          StreamPhase.unavailable => (l10n.liveUnavailable, AppColors.loss),
        };
        return Tooltip(
          message: s.message ?? label,
          child: StatusChip(label, color: color, icon: Icons.circle),
        );
      },
    );
  }
}
