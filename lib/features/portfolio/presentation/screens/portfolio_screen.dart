import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/app/shell/tab_actions.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:agentfolio/core/presentation/widgets/error_view.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/logic/portfolio_insights.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/portfolio_view_model.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/portfolio_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key, this.showView});

  /// From a link elsewhere (`orders`, after an approval): switch to that
  /// view, with fresh data.
  final String? showView;

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<PortfolioViewModel>().load());
    _applyShowView();
  }

  @override
  void didUpdateWidget(PortfolioScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _applyShowView();
  }

  void _applyShowView() {
    final view = PortfolioView.values.where((v) => v.name == widget.showView).firstOrNull;
    if (view == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final vm = context.read<PortfolioViewModel>()..selectView(view);
      if (view == PortfolioView.orders) unawaited(vm.orders.load(force: true));
      // Drop the parameter, so coming back to the tab does not reapply it.
      context.go(Routes.portfolio);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PortfolioViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabPortfolio),
        titleSpacing: AppSpace.page,
        actions: [
          AppIconButton(
            trackId: 'portfolio_rebalancer',
            icon: Icons.tune_rounded,
            tooltip: l10n.rebalancerTitle,
            onPressed: () => unawaited(context.push(Routes.rebalancer)),
          ),
          const TabActions(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.page,
              AppSpace.xs,
              AppSpace.page,
              AppSpace.md,
            ),
            child: AppSegmented<PortfolioView>(
              trackId: 'portfolio_view',
              selected: vm.view,
              onChanged: vm.selectView,
              segments: [
                AppSegment(
                  value: PortfolioView.holdings,
                  label: l10n.portfolioHoldings,
                  id: 'holdings',
                ),
                AppSegment(
                  value: PortfolioView.positions,
                  label: l10n.portfolioPositions,
                  id: 'positions',
                ),
                AppSegment(value: PortfolioView.orders, label: l10n.portfolioOrders, id: 'orders'),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: AppMotion.of(context, AppMotion.medium),
              switchInCurve: AppMotion.enter,
              child: KeyedSubtree(
                key: ValueKey(vm.view),
                child: RefreshIndicator(
                  onRefresh: vm.refresh,
                  child: switch (vm.view) {
                    PortfolioView.holdings => const _HoldingsView(),
                    PortfolioView.positions => const _PositionsView(),
                    PortfolioView.orders => const _OrdersView(),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared states for every segment: skeleton, error, empty, then the list.
/// Always scrollable, so pull-to-refresh works even on an empty list.
class _LoadableList<T> extends StatelessWidget {
  const _LoadableList({
    required this.loadable,
    required this.retryTrackId,
    required this.isEmpty,
    required this.empty,
    required this.slivers,
  });

  final Loadable<T> loadable;
  final String retryTrackId;
  final bool Function(T data) isEmpty;
  final Widget empty;
  final List<Widget> Function(T data) slivers;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    slivers: switch (loadable.state) {
      ViewIdle() || ViewLoading() => [const SliverToBoxAdapter(child: _ListSkeleton())],
      ViewError(:final failure) => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            failure: failure,
            retryTrackId: retryTrackId,
            onRetry: () => unawaited(loadable.load(force: true)),
          ),
        ),
      ],
      ViewData(:final data) when isEmpty(data) => [
        SliverFillRemaining(hasScrollBody: false, child: empty),
      ],
      ViewData(:final data) => [
        ...slivers(data),
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    },
  );
}

class _HoldingsView extends StatelessWidget {
  const _HoldingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PortfolioViewModel>();
    final visible = vm.visibleHoldings;

    return _LoadableList<PortfolioSnapshot>(
      loadable: vm.snapshot,
      retryTrackId: 'holdings_retry',
      isEmpty: (s) => s.holdings.isEmpty,
      empty: EmptyState(
        icon: Icons.inventory_2_outlined,
        title: l10n.homeNoHoldingsTitle,
        message: l10n.homeNoHoldingsBody,
      ),
      slivers: (snapshot) => [
        SliverToBoxAdapter(child: _HoldingsSummary(snapshot: snapshot)),
        const SliverToBoxAdapter(child: _SearchAndSort()),
        if (visible.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.search_off_rounded,
              title: l10n.holdingsNoMatch(vm.query),
            ),
          )
        else
          SliverList.separated(
            itemCount: visible.length,
            itemBuilder: (context, i) => HoldingTile(holding: visible[i]),
            separatorBuilder: (context, _) =>
                Divider(height: 1, indent: 72, color: context.palette.border),
          ),
      ],
    );
  }
}

class _HoldingsSummary extends StatelessWidget {
  const _HoldingsSummary({required this.snapshot});

  final PortfolioSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = snapshot.summary;
    Widget cell(String label, Widget value) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.text.labelMedium),
          const SizedBox(height: 2),
          DefaultTextStyle.merge(style: context.text.titleSmall, child: value),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.xs, AppSpace.page, AppSpace.md),
      child: Row(
        children: [
          cell(l10n.holdingsCount, Text('${snapshot.holdings.length}')),
          cell(l10n.homeInvested, MoneyText(s.totalInvested, format: MoneyStyle.compact)),
          cell(l10n.holdingsValue, MoneyText(s.currentValue, format: MoneyStyle.compact)),
          cell(l10n.holdingsReturns, PnlPercent(s.overallPnlPercent, showArrow: false)),
        ],
      ),
    );
  }
}

class _SearchAndSort extends StatefulWidget {
  const _SearchAndSort();

  @override
  State<_SearchAndSort> createState() => _SearchAndSortState();
}

class _SearchAndSortState extends State<_SearchAndSort> {
  late final _controller = TextEditingController(text: context.read<PortfolioViewModel>().query);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickSort() async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<PortfolioViewModel>();
    context.trackTap('holdings_sort');
    final picked = await showModalBottomSheet<HoldingSort>(
      context: context,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.sm),
              child: Text(l10n.holdingsSortBy, style: context.text.titleLarge),
            ),
            RadioGroup<HoldingSort>(
              groupValue: vm.sort,
              onChanged: (value) => Navigator.of(context).pop(value),
              child: Column(
                children: [
                  for (final sort in HoldingSort.values)
                    RadioListTile<HoldingSort>(value: sort, title: Text(_sortLabel(l10n, sort))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if (picked != null && mounted) {
      HapticFeedback.selectionClick().ignore();
      context.trackChange('holdings_sort', picked.name);
      vm.setSort(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PortfolioViewModel>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.sm),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 44,
              child: TextField(
                controller: _controller,
                onChanged: vm.setQuery,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.characters,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: l10n.holdingsSearch,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  suffixIcon: vm.query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: l10n.holdingsClearSearch,
                          icon: const Icon(Icons.close_rounded, size: 18),
                          onPressed: () {
                            _controller.clear();
                            vm.setQuery('');
                          },
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          ActionChip(
            avatar: const Icon(Icons.swap_vert_rounded, size: 18, color: AppColors.textSecondary),
            label: Text(_sortLabel(l10n, vm.sort)),
            onPressed: () => unawaited(_pickSort()),
          ),
        ],
      ),
    );
  }

  static String _sortLabel(AppLocalizations l10n, HoldingSort sort) => switch (sort) {
    HoldingSort.currentValue => l10n.holdingsSortValue,
    HoldingSort.pnl => l10n.holdingsSortPnl,
    HoldingSort.pnlPercent => l10n.holdingsSortPnlPercent,
    HoldingSort.invested => l10n.holdingsSortInvested,
    HoldingSort.name => l10n.holdingsSortName,
  };
}

class _PositionsView extends StatelessWidget {
  const _PositionsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PortfolioViewModel>();
    return _LoadableList<Positions>(
      loadable: vm.positions,
      retryTrackId: 'positions_retry',
      isEmpty: (p) => p.positions.isEmpty,
      empty: EmptyState(
        icon: Icons.swap_horiz_rounded,
        title: l10n.positionsEmptyTitle,
        message: l10n.positionsEmptyBody,
      ),
      slivers: (data) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.page,
              AppSpace.xs,
              AppSpace.page,
              AppSpace.md,
            ),
            child: Row(
              children: [
                Text(l10n.positionsDayPnl, style: context.text.labelMedium),
                const SizedBox(width: AppSpace.sm),
                MoneyText(
                  data.totalPnl,
                  format: MoneyStyle.change,
                  style: context.text.titleMedium,
                ),
                const Spacer(),
                Text(l10n.positionsOpen(data.positions.length), style: context.text.labelMedium),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemCount: data.positions.length,
          itemBuilder: (context, i) => PositionTile(position: data.positions[i]),
          separatorBuilder: (context, _) =>
              Divider(height: 1, indent: 72, color: context.palette.border),
        ),
      ],
    );
  }
}

class _OrdersView extends StatelessWidget {
  const _OrdersView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PortfolioViewModel>();
    String count(List<Object>? list) => list == null ? '' : ' (${list.length})';

    final switcher = Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.sm),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 280,
          child: AppSegmented<OrdersView>(
            trackId: 'orders_view',
            selected: vm.ordersView,
            onChanged: vm.selectOrdersView,
            segments: [
              AppSegment(
                value: OrdersView.orders,
                label: '${l10n.ordersOrders}${count(vm.orders.data)}',
                id: 'orders',
              ),
              AppSegment(
                value: OrdersView.trades,
                label: '${l10n.ordersTrades}${count(vm.trades.data)}',
                id: 'trades',
              ),
            ],
          ),
        ),
      ),
    );

    return Column(
      children: [
        switcher,
        Expanded(
          child: switch (vm.ordersView) {
            OrdersView.orders => _LoadableList<List<Order>>(
              loadable: vm.orders,
              retryTrackId: 'orders_retry',
              isEmpty: (o) => o.isEmpty,
              empty: EmptyState(icon: Icons.receipt_long_outlined, title: l10n.ordersEmpty),
              slivers: (orders) => [
                SliverList.separated(
                  itemCount: orders.length,
                  itemBuilder: (context, i) => OrderTile(order: orders[i]),
                  separatorBuilder: (context, _) =>
                      Divider(height: 1, indent: 72, color: context.palette.border),
                ),
              ],
            ),
            OrdersView.trades => _LoadableList<List<Trade>>(
              loadable: vm.trades,
              retryTrackId: 'trades_retry',
              isEmpty: (t) => t.isEmpty,
              empty: EmptyState(icon: Icons.done_all_rounded, title: l10n.tradesEmpty),
              slivers: (trades) => [
                SliverList.separated(
                  itemCount: trades.length,
                  itemBuilder: (context, i) => TradeTile(trade: trades[i]),
                  separatorBuilder: (context, _) =>
                      Divider(height: 1, indent: 72, color: context.palette.border),
                ),
              ],
            ),
          },
        ),
      ],
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) => Shimmer(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.page, vertical: AppSpace.sm),
      child: Column(
        children: [
          for (var i = 0; i < 7; i++)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpace.md),
              child: Row(
                children: [
                  SkeletonBox(width: 40, height: 40, radius: Radius.circular(20)),
                  SizedBox(width: AppSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox(width: 90),
                        SizedBox(height: 6),
                        SkeletonBox(width: 140, height: 10),
                      ],
                    ),
                  ),
                  SkeletonBox(width: 70),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
