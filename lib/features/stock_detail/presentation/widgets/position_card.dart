import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// What the user owns of this stock and how it is doing. Amounts follow
/// "Hide balances".
class PositionCard extends StatelessWidget {
  const PositionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<StockDetailViewModel>();
    final h = vm.holding;
    if (h == null) return const SizedBox.shrink();
    final weight = vm.portfolioWeight;

    return SectionCard(
      title: l10n.stockPositionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: MoneyText(
                  h.pnl,
                  format: MoneyStyle.change,
                  style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              PnlPercent(h.pnlPercent, style: context.text.titleMedium),
            ],
          ),
          Text(l10n.stockOverallReturn, style: context.text.labelMedium),
          const SizedBox(height: AppSpace.lg),
          _Grid(
            cells: [
              (l10n.holdingQuantity, Text(Fmt.number(h.quantity))),
              (l10n.holdingAverage, Text(Fmt.money(h.averagePrice))),
              (l10n.homeInvested, MoneyText(h.invested, format: MoneyStyle.rupees)),
              (l10n.homeCurrentValue, MoneyText(h.currentValue, format: MoneyStyle.rupees)),
            ],
          ),
          if (weight != null) ...[
            const SizedBox(height: AppSpace.lg),
            Row(
              children: [
                Expanded(child: Text(l10n.stockWeight, style: context.text.labelMedium)),
                Text(Fmt.percent(weight * 100), style: context.text.labelLarge?.tabular),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: weight.clamp(0, 1),
                minHeight: 6,
                color: AppColors.brandSoft,
                backgroundColor: context.palette.surfaceRaised,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Label-over-value pairs, two to a row.
class _Grid extends StatelessWidget {
  const _Grid({required this.cells});

  final List<(String, Widget)> cells;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < cells.length; i += 2) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (label, value) in cells.skip(i).take(2))
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: context.text.labelMedium),
                    const SizedBox(height: 2),
                    DefaultTextStyle.merge(style: context.text.titleSmall?.tabular, child: value),
                  ],
                ),
              ),
          ],
        ),
      );
    }
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpace.md),
          rows[i],
        ],
      ],
    );
  }
}
