import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:flutter/material.dart';

/// The headline: what the portfolio is worth now, what went in, and how it is
/// doing overall and today. The value counts up when it changes.
class HeroCard extends StatelessWidget {
  const HeroCard({required this.snapshot, required this.refreshing, super.key});

  final PortfolioSnapshot snapshot;
  final bool refreshing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = snapshot.summary;
    return DecoratedBox(
      // A hairline of the brand gradient around the card.
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: AppRadius.card.add(const BorderRadius.all(Radius.circular(1))),
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(AppSpace.xl - 4),
        decoration: BoxDecoration(
          borderRadius: AppRadius.card,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.alphaBlend(AppColors.indigo.withValues(alpha: 0.10), AppColors.surface),
              AppColors.surface,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.homeCurrentValue,
                    style: context.text.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpace.sm),
                Flexible(
                  child: _Freshness(fetchedAt: snapshot.fetchedAt, refreshing: refreshing),
                ),
              ],
            ),
            const SizedBox(height: AppSpace.xs),
            if (s.currentValue == null)
              Text('—', style: context.text.displaySmall)
            else
              AnimatedMoney(s.currentValue!, style: context.text.displaySmall),
            const SizedBox(height: AppSpace.xs),
            Wrap(
              children: [
                Text('${l10n.homeInvested} ', style: context.text.bodySmall),
                MoneyText(
                  s.totalInvested,
                  format: MoneyStyle.rupees,
                  style: context.text.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpace.lg),
            Row(
              children: [
                Expanded(
                  child: _Change(
                    label: l10n.homeOverallPnl,
                    amount: s.overallPnl,
                    percent: s.overallPnlPercent,
                  ),
                ),
                Container(width: 1, height: 36, color: context.palette.border),
                const SizedBox(width: AppSpace.lg),
                // Absent when no positions are open today: a real zero.
                Expanded(
                  child: _Change(label: l10n.homeDayPnl, amount: s.dayPnl ?? 0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Change extends StatelessWidget {
  const _Change({required this.label, required this.amount, this.percent});

  final String label;
  final double? amount;
  final double? percent;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: context.text.labelMedium),
      const SizedBox(height: 2),
      MoneyText(amount, format: MoneyStyle.change, style: context.text.titleMedium),
      if (percent != null) PnlPercent(percent, style: context.text.labelMedium),
    ],
  );
}

/// "Updated 2m ago", or a small spinner while a refresh is in flight.
class _Freshness extends StatelessWidget {
  const _Freshness({required this.fetchedAt, required this.refreshing});

  final DateTime fetchedAt;
  final bool refreshing;

  @override
  Widget build(BuildContext context) {
    final style = context.text.labelSmall?.copyWith(color: AppColors.textMuted, letterSpacing: 0);
    if (refreshing) {
      return const SizedBox.square(
        dimension: 14,
        child: CircularProgressIndicator(strokeWidth: 1.6),
      );
    }
    return Text(
      AppLocalizations.of(context).homeUpdated(Times.relative(fetchedAt)),
      style: style,
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
    );
  }
}
