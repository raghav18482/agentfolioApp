import 'dart:math' as math;

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/logic/price_history_logic.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The symbol, last price and the day's move, large, collapsing into the
/// toolbar as the page scrolls so the price stays in sight. The tabs pin
/// beneath it.
class StockHeader extends StatelessWidget {
  const StockHeader({required this.bottom, required this.forceElevated, super.key});

  final PreferredSizeWidget bottom;
  final bool forceElevated;

  /// The expanded block's height at 1.0 text scale.
  static const _content = 92.0;

  @override
  Widget build(BuildContext context) {
    final content = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 2).scale(_content);
    return SliverAppBar(
      pinned: true,
      forceElevated: forceElevated,
      expandedHeight: kToolbarHeight + content + bottom.preferredSize.height,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      bottom: bottom,
      actions: const [_AskAgentAction()],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = MediaQuery.paddingOf(context).top;
          final min = top + kToolbarHeight + bottom.preferredSize.height;
          final max = min + content;
          // 1 fully expanded, 0 collapsed.
          final t = ((constraints.maxHeight - min) / (max - min)).clamp(0.0, 1.0);
          return Stack(
            children: [
              // The collapsed title, beside the back button.
              Positioned(
                left: 56,
                right: 56,
                top: top,
                height: kToolbarHeight,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: (1 - t * 2).clamp(0.0, 1.0),
                    child: const Align(alignment: Alignment.centerLeft, child: _CompactTitle()),
                  ),
                ),
              ),
              Positioned(
                left: AppSpace.page,
                right: AppSpace.page,
                top: top + kToolbarHeight - (1 - t) * 24,
                height: content,
                child: Opacity(opacity: math.max(0, t * 1.6 - 0.6), child: const _ExpandedBlock()),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ExpandedBlock extends StatelessWidget {
  const _ExpandedBlock();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StockDetailViewModel>();
    final price = vm.lastPrice;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                Fmt.symbol(vm.symbol),
                style: context.text.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpace.sm),
            _ExchangeChip(held: vm.holding != null),
          ],
        ),
        const SizedBox(height: AppSpace.xs),
        if (price == null)
          const Shimmer(child: SkeletonBox(width: 150, height: 34))
        else
          // A market price, not a balance: never hidden.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              Fmt.money(price),
              style: context.text.headlineMedium?.tabular.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        const SizedBox(height: 2),
        _DayMove(move: vm.dayMove),
      ],
    );
  }
}

class _CompactTitle extends StatelessWidget {
  const _CompactTitle();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StockDetailViewModel>();
    final move = vm.dayMove;
    return Row(
      children: [
        Flexible(
          child: Text(
            Fmt.symbol(vm.symbol),
            style: context.text.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpace.md),
        if (vm.lastPrice case final price?)
          Flexible(
            child: Text(
              Fmt.money(price),
              style: context.text.titleSmall?.tabular,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
        if (move != null) ...[
          const SizedBox(width: AppSpace.sm),
          Flexible(child: PnlPercent(move.percent, style: context.text.labelMedium)),
        ],
      ],
    );
  }
}

/// `▲ +₹12.40 (+0.51%) · 1D`
class _DayMove extends StatelessWidget {
  const _DayMove({required this.move});

  final PriceChange? move;

  @override
  Widget build(BuildContext context) {
    final m = move;
    if (m == null) return const SizedBox(height: 20);
    final l10n = AppLocalizations.of(context);
    final color = context.palette.pnl(m.amount);
    final style = context.text.bodyMedium?.tabular.copyWith(
      color: color,
      fontWeight: FontWeight.w600,
    );
    // Wraps rather than spills at large text sizes.
    return Wrap(
      spacing: AppSpace.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        PnlPercent(m.percent, style: style),
        Text('(${Fmt.signedMoney(m.amount)})', style: style),
        Text(
          l10n.stockOneDay,
          style: context.text.labelMedium?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _ExchangeChip extends StatelessWidget {
  const _ExchangeChip({required this.held});

  final bool held;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget chip(String text, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text, style: context.text.labelSmall?.copyWith(color: color, letterSpacing: 0.4)),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        chip('NSE', AppColors.textSecondary),
        if (held) ...[const SizedBox(width: 6), chip(l10n.stockHeld, AppColors.emerald)],
      ],
    );
  }
}

/// Opens the agent with a question about this stock ready to send.
class _AskAgentAction extends StatelessWidget {
  const _AskAgentAction();

  @override
  Widget build(BuildContext context) {
    final symbol = Fmt.symbol(context.read<StockDetailViewModel>().symbol);
    return AppIconButton(
      trackId: 'stock_ask_agent',
      icon: Icons.forum_outlined,
      tooltip: AppLocalizations.of(context).stockAskAgent(symbol),
      onPressed: () => context.go(Routes.agentAbout(symbol)),
    );
  }
}
