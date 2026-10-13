import 'dart:async';
import 'dart:math' as math;

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/logic/portfolio_insights.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/holding_sheet.dart';
import 'package:flutter/material.dart';

/// The biggest gains and losses in rupees, as two ranked lists with bars
/// scaled to the largest move. On a phone this reads better than the web's
/// horizontal bar chart: labels never collide and every row is tappable.
class TopMoversCard extends StatelessWidget {
  const TopMoversCard({required this.holdings, super.key});

  final List<Holding> holdings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final movers = topMovers(holdings);
    final scale = [
      ...movers.gainers,
      ...movers.losers,
    ].fold<double>(1, (m, h) => math.max(m, h.pnl.abs()));

    return SectionCard(
      title: l10n.homeMoversTitle,
      subtitle: l10n.homeMoversSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Group(title: l10n.homeMoversGainers, holdings: movers.gainers, scale: scale),
          if (movers.gainers.isNotEmpty && movers.losers.isNotEmpty)
            const SizedBox(height: AppSpace.lg),
          _Group(title: l10n.homeMoversLosers, holdings: movers.losers, scale: scale),
          if (movers.gainers.isEmpty && movers.losers.isEmpty)
            Text(l10n.homeMoversFlat, style: context.text.bodySmall),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.holdings, required this.scale});

  final String title;
  final List<Holding> holdings;
  final double scale;

  @override
  Widget build(BuildContext context) {
    if (holdings.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title.toUpperCase(), style: context.text.labelSmall),
        const SizedBox(height: AppSpace.xs),
        for (final h in holdings) _MoverRow(holding: h, fraction: h.pnl.abs() / scale),
      ],
    );
  }
}

/// Two lines, so nothing is ever cut off: symbol and rupee change, then the
/// bar and the percentage under them.
class _MoverRow extends StatelessWidget {
  const _MoverRow({required this.holding, required this.fraction});

  final Holding holding;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final color = context.palette.pnl(holding.pnl);
    return InkWell(
      onTap: () => openStock(context, holding.symbol, trackId: 'mover_open'),
      onLongPress: () => unawaited(showHoldingSheet(context, holding)),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    holding.displaySymbol,
                    style: context.text.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpace.md),
                MoneyText(
                  holding.pnl,
                  format: MoneyStyle.changeRupees,
                  style: context.text.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, c) => Align(
                      alignment: Alignment.centerLeft,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: fraction.clamp(0.03, 1)),
                        duration: AppMotion.of(context, AppMotion.long),
                        curve: AppMotion.enter,
                        builder: (context, f, _) => Container(
                          height: 6,
                          width: c.maxWidth * f,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: LinearGradient(
                              colors: [color.withValues(alpha: 0.25), color],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpace.md),
                PnlPercent(holding.pnlPercent, style: context.text.labelMedium, showArrow: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
