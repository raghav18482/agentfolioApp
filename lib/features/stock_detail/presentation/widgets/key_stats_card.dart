import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Where the price sits: in its 52-week range, against its moving averages,
/// on RSI, and how busy today is. Read from the technicals already loaded
/// for the chart.
class KeyStatsCard extends StatelessWidget {
  const KeyStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<StockDetailViewModel>();
    final state = context.select<StockDetailViewModel, ViewState<Technicals>>(
      (vm) => vm.technicals.state,
    );
    final price = context.select<StockDetailViewModel, double?>((vm) => vm.lastPrice);

    return SectionCard(
      title: l10n.stockKeyStatsTitle,
      child: SectionState(
        state: state,
        retryTrackId: 'stock_stats_retry',
        onRetry: () => vm.technicals.load(force: true),
        skeleton: const Column(
          children: [
            SkeletonBox(width: double.infinity, height: 36),
            SizedBox(height: AppSpace.md),
            SkeletonBox(width: double.infinity, height: 80),
          ],
        ),
        builder: (context, data) {
          final i = data.indicators;
          final ltp = price ?? data.currentPrice;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (i.week52Low != null && i.week52High != null)
                _RangeBar(low: i.week52Low!, high: i.week52High!, value: ltp),
              const SizedBox(height: AppSpace.lg),
              _Stat(
                label: l10n.stockDma50,
                value: Fmt.money(i.sma50),
                chip: _versus(l10n, ltp, i.sma50),
              ),
              _Stat(
                label: l10n.stockDma200,
                value: Fmt.money(i.sma200),
                chip: _versus(l10n, ltp, i.sma200),
              ),
              _Stat(
                label: l10n.stockRsi,
                value: i.rsi == null ? Fmt.missing : i.rsi!.toStringAsFixed(1),
                chip: _rsiZone(l10n, i.rsi),
              ),
              _Stat(label: l10n.stockVolumeRatio, value: Fmt.multiple(i.volumeRatio)),
            ],
          );
        },
      ),
    );
  }

  static (String, Color)? _versus(AppLocalizations l10n, double price, double? average) {
    if (average == null) return null;
    return price >= average ? (l10n.stockAbove, AppColors.gain) : (l10n.stockBelow, AppColors.loss);
  }

  static (String, Color)? _rsiZone(AppLocalizations l10n, double? rsi) => switch (rsi) {
    null => null,
    >= 70 => (l10n.rsiOverbought, AppColors.orange),
    <= 30 => (l10n.rsiOversold, AppColors.info),
    _ => (l10n.rsiNeutral, AppColors.textSecondary),
  };
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, this.chip});

  final String label;
  final String value;
  final (String, Color)? chip;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.text.bodyMedium?.copyWith(color: context.palette.neutral),
          ),
        ),
        if (chip case (final text, final color)) ...[
          StatusChip(text.toUpperCase(), color: color),
          const SizedBox(width: AppSpace.sm),
        ],
        Flexible(
          child: Text(value, style: context.text.titleSmall?.tabular, textAlign: TextAlign.end),
        ),
      ],
    ),
  );
}

/// The 52-week low and high with a marker where the price is now.
class _RangeBar extends StatelessWidget {
  const _RangeBar({required this.low, required this.high, required this.value});

  final double low;
  final double high;
  final double value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = high > low ? ((value - low) / (high - low)).clamp(0.0, 1.0) : 0.5;
    return Semantics(
      label: l10n.stock52wSemantics(
        Fmt.money(low),
        Fmt.money(high),
        Fmt.percent(t * 100, decimals: 0),
      ),
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(l10n.stock52wRange, style: context.text.labelMedium)),
              Flexible(
                child: Text(
                  l10n.stock52wPosition(Fmt.percent(t * 100, decimals: 0)),
                  textAlign: TextAlign.end,
                  style: context.text.labelMedium?.copyWith(color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.sm),
          LayoutBuilder(
            builder: (context, c) => SizedBox(
              height: 14,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      gradient: const LinearGradient(
                        colors: [AppColors.lossStrong, AppColors.warning, AppColors.gainStrong],
                      ),
                    ),
                  ),
                  Positioned(
                    left: (c.maxWidth - 14) * t,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.textPrimary,
                        border: Border.all(color: AppColors.background, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: Text(Fmt.money(low), style: context.text.labelSmall?.tabular)),
              Text(Fmt.money(high), style: context.text.labelSmall?.tabular),
            ],
          ),
        ],
      ),
    );
  }
}
