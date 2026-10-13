import 'dart:math' as math;

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/charts/chart_palette.dart';
import 'package:agentfolio/core/presentation/charts/treemap.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/holding_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Holdings as tiles: area is current value, colour is gain or loss.
///
/// Beyond [maxTiles] holdings, the smallest are folded into one "Others"
/// tile: a phone cannot show 40 readable, tappable tiles.
class PnlHeatmapCard extends StatelessWidget {
  const PnlHeatmapCard({required this.holdings, super.key});

  final List<Holding> holdings;

  static const maxTiles = 12;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final live = holdings.where((h) => h.currentValue > 0).toList()
      ..sort((a, b) => b.currentValue.compareTo(a.currentValue));
    final shown = live.length > maxTiles ? live.take(maxTiles - 1).toList() : live;
    final rest = live.skip(shown.length).toList();
    final maxAbsPct = live.fold<double>(1, (m, h) => math.max(m, h.pnlPercent.abs()));

    final tiles = [
      for (final h in shown)
        TreemapTile(
          label: h.displaySymbol,
          value: h.currentValue,
          caption: Fmt.signedPct(h.pnlPercent, decimals: 1),
          color: ChartPalette.pnl(h.pnl, h.pnlPercent.abs() / maxAbsPct),
        ),
      if (rest.isNotEmpty) _othersTile(rest, maxAbsPct, l10n),
    ];

    return SectionCard(
      title: l10n.homeHeatmapTitle,
      subtitle: l10n.homeHeatmapSubtitle,
      child: Treemap(
        tiles: tiles,
        semanticLabel: l10n.homeHeatmapSemantics(live.length),
        onTap: (i) {
          if (i < shown.length) {
            openStock(context, shown[i].symbol, trackId: 'heatmap_tile');
          } else {
            // "+N more": the full list lives on the Portfolio tab.
            context
              ..trackTap('heatmap_more')
              ..go(Routes.portfolio);
          }
        },
      ),
    );
  }

  TreemapTile _othersTile(List<Holding> rest, double maxAbsPct, AppLocalizations l10n) {
    final value = rest.fold<double>(0, (s, h) => s + h.currentValue);
    final invested = rest.fold<double>(0, (s, h) => s + h.invested);
    final pnl = value - invested;
    final pct = invested == 0 ? 0.0 : pnl / invested * 100;
    return TreemapTile(
      label: l10n.homeHeatmapOthers(rest.length),
      value: value,
      caption: Fmt.signedPct(pct, decimals: 1),
      color: ChartPalette.pnl(pnl, pct.abs() / maxAbsPct),
    );
  }
}
