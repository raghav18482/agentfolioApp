import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/holding_sheet.dart';
import 'package:flutter/material.dart';

/// List rows for holdings, positions, orders and trades. Cards instead of the
/// web's tables: the two numbers that matter sit on the right, the rest in a
/// quiet second line, and nothing scrolls sideways.

class HoldingTile extends StatelessWidget {
  const HoldingTile({required this.holding, super.key});

  final Holding holding;

  @override
  Widget build(BuildContext context) {
    final h = holding;
    return _Row(
      onTap: () => openStock(context, h.symbol, trackId: 'holding_open'),
      onLongPress: () => showHoldingSheet(context, h),
      leading: _Initial(h.displaySymbol, color: context.palette.pnl(h.pnl)),
      title: Text(h.displaySymbol, style: context.text.titleSmall),
      subtitle: Text(
        '${Fmt.number(h.quantity)} × ${Fmt.money(h.averagePrice)}',
        style: context.text.bodySmall?.tabular,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MoneyText(h.currentValue, format: MoneyStyle.rupees, style: context.text.titleSmall),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MoneyText(h.pnl, format: MoneyStyle.change, style: context.text.labelMedium),
              const SizedBox(width: 6),
              PnlPercent(h.pnlPercent, style: context.text.labelMedium, showArrow: false),
            ],
          ),
        ],
      ),
    );
  }
}

class PositionTile extends StatelessWidget {
  const PositionTile({required this.position, super.key});

  final Position position;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = position;
    return _Row(
      leading: _Initial(p.displaySymbol, color: context.palette.pnl(p.pnl)),
      title: Row(
        children: [
          Flexible(child: Text(p.displaySymbol, style: context.text.titleSmall)),
          const SizedBox(width: AppSpace.sm),
          StatusChip(p.product),
        ],
      ),
      subtitle: Text(
        l10n.positionDetail(
          Fmt.number(p.netQuantity),
          Fmt.money(p.buyAverage),
          Fmt.money(p.sellAverage),
        ),
        style: context.text.bodySmall?.tabular,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MoneyText(p.pnl, format: MoneyStyle.change, style: context.text.titleSmall),
          Text(l10n.positionLtp(Fmt.money(p.lastPrice)), style: context.text.labelMedium?.tabular),
        ],
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final o = order;
    final (color, icon) = switch (o.state) {
      OrderState.complete => (context.palette.gain, Icons.check_circle_outline_rounded),
      OrderState.closed => (context.palette.loss, Icons.cancel_outlined),
      OrderState.pending => (context.palette.warning, Icons.schedule_rounded),
    };
    return _Row(
      leading: _SideBadge(o.side),
      title: Text(o.displaySymbol, style: context.text.titleSmall),
      subtitle: Text(
        '${Fmt.number(o.quantity)} @ ${Fmt.money(o.price)} · ${o.time}',
        style: context.text.bodySmall?.tabular,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: StatusChip(o.status.toUpperCase(), color: color, icon: icon),
      footer: _Id(o.orderId),
    );
  }
}

class TradeTile extends StatelessWidget {
  const TradeTile({required this.trade, super.key});

  final Trade trade;

  @override
  Widget build(BuildContext context) {
    final t = trade;
    return _Row(
      leading: _SideBadge(t.side),
      title: Row(
        children: [
          Flexible(child: Text(t.displaySymbol, style: context.text.titleSmall)),
          const SizedBox(width: AppSpace.sm),
          StatusChip(t.product),
        ],
      ),
      subtitle: Text(
        '${Fmt.number(t.quantity)} @ ${Fmt.money(t.price)} · ${t.exchange} · ${t.time}',
        style: context.text.bodySmall?.tabular,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: MoneyText(
        t.quantity * t.price,
        format: MoneyStyle.rupees,
        style: context.text.titleSmall,
      ),
      footer: _Id(t.tradeId),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.footer,
    this.onTap,
    this.onLongPress,
  });

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget? footer;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    onLongPress: onLongPress,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.page, vertical: AppSpace.md),
      child: Row(
        children: [
          leading,
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, const SizedBox(height: 2), subtitle, ?footer],
            ),
          ),
          const SizedBox(width: AppSpace.md),
          trailing,
        ],
      ),
    ),
  );
}

/// The symbol's first letter on a tinted disc: a scannable anchor per row.
class _Initial extends StatelessWidget {
  const _Initial(this.symbol, {required this.color});

  final String symbol;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 40,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Text(
      symbol.isEmpty ? '?' : symbol.characters.first,
      style: context.text.titleMedium?.copyWith(color: color),
    ),
  );
}

class _SideBadge extends StatelessWidget {
  const _SideBadge(this.side);

  final OrderSide side;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (side) {
      OrderSide.buy => ('B', context.palette.gain),
      OrderSide.sell => ('S', context.palette.loss),
      OrderSide.other => ('•', context.palette.neutral),
    };
    return Semantics(
      label: switch (side) {
        OrderSide.buy => 'Buy',
        OrderSide.sell => 'Sell',
        OrderSide.other => 'Order',
      },
      excludeSemantics: true,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label, style: context.text.titleMedium?.copyWith(color: color)),
      ),
    );
  }
}

class _Id extends StatelessWidget {
  const _Id(this.id);

  final String id;

  @override
  Widget build(BuildContext context) => id.isEmpty
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '#$id',
            style: context.text.labelSmall?.copyWith(
              color: AppColors.textMuted,
              letterSpacing: 0,
              fontFeatures: AppTypography.tabular,
            ),
          ),
        );
}
