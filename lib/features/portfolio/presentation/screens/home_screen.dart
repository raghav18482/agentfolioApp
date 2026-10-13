import 'dart:async';

import 'package:agentfolio/app/shell/tab_actions.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/responsive/window_size.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/brand/brand_mark.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:agentfolio/core/presentation/widgets/error_view.dart';
import 'package:agentfolio/core/presentation/widgets/fade_slide_in.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ai_insights_card.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ask_ai_card.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/home_view_model.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/allocation_card.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/benchmark_card.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/hero_card.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/pnl_heatmap_card.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/top_movers_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<HomeViewModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<HomeViewModel>();
    final state = vm.snapshot.state;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        edgeOffset: 100,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              titleSpacing: AppSpace.page,
              title: Row(
                children: [
                  const BrandMark(size: 28),
                  const SizedBox(width: AppSpace.md),
                  Flexible(child: Text(l10n.appName, overflow: TextOverflow.ellipsis)),
                ],
              ),
              actions: const [TabActions()],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.page,
                AppSpace.sm,
                AppSpace.page,
                AppSpace.xxl,
              ),
              sliver: switch (state) {
                ViewIdle() || ViewLoading() => const SliverToBoxAdapter(child: _HomeSkeleton()),
                ViewError(:final failure) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorView(
                    failure: failure,
                    retryTrackId: 'home_retry',
                    onRetry: () => unawaited(vm.snapshot.load(force: true)),
                  ),
                ),
                ViewData(:final data, :final refreshing, :final refreshFailure) =>
                  SliverToBoxAdapter(
                    child: _HomeContent(
                      snapshot: data,
                      refreshing: refreshing,
                      staleBecause: refreshFailure?.message,
                    ),
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.snapshot, required this.refreshing, this.staleBecause});

  final PortfolioSnapshot snapshot;
  final bool refreshing;

  /// Set when the last refresh failed and older data is showing.
  final String? staleBecause;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<HomeViewModel>();
    final sectorMap = context.select<HomeViewModel, SectorMap?>((v) => v.sectorMap.data);
    final hasHoldings = snapshot.holdings.isNotEmpty;
    final wide = WindowSize.of(context).twoPane;

    final cards = <Widget>[
      if (hasHoldings) ...[
        PnlHeatmapCard(holdings: snapshot.holdings),
        TopMoversCard(holdings: snapshot.holdings),
        AllocationCard(snapshot: snapshot, sectorMap: sectorMap),
        BenchmarkCard(benchmark: vm.benchmark, onVisible: () => unawaited(vm.revealBenchmark())),
        const AiInsightsCard(),
        const AskAiCard(),
      ],
    ];

    var delay = 0;
    Widget enter(Widget child) => FadeSlideIn(
      delay: Duration(milliseconds: 70 * delay++),
      child: child,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (staleBecause != null) ...[
          AppAlert(
            variant: AppAlertVariant.warning,
            title: l10n.homeStaleTitle(Times.relative(snapshot.fetchedAt)),
            message: staleBecause!,
            action: AppButton(
              trackId: 'home_stale_retry',
              label: l10n.commonRetry,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              onPressed: () => unawaited(vm.refresh()),
            ),
          ),
          const SizedBox(height: AppSpace.lg),
        ],
        enter(HeroCard(snapshot: snapshot, refreshing: refreshing)),
        const SizedBox(height: AppSpace.md),
        enter(_FundsRow(funds: snapshot.funds)),
        const SizedBox(height: AppSpace.lg),
        if (!hasHoldings)
          enter(
            EmptyState(
              icon: Icons.inventory_2_outlined,
              title: l10n.homeNoHoldingsTitle,
              message: l10n.homeNoHoldingsBody,
            ),
          )
        else if (wide)
          _TwoColumns(children: [for (final c in cards) enter(c)])
        else
          for (final card in cards) ...[enter(card), const SizedBox(height: AppSpace.lg)],
      ],
    );
  }
}

class _FundsRow extends StatelessWidget {
  const _FundsRow({required this.funds});

  final Funds funds;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: StatTile(
            icon: Icons.account_balance_wallet_outlined,
            label: l10n.homeAvailableCash,
            value: MoneyText(funds.availableCash, format: MoneyStyle.rupees),
          ),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: StatTile(
            icon: Icons.savings_outlined,
            label: l10n.homeNetValue,
            value: MoneyText(funds.net, format: MoneyStyle.rupees),
          ),
        ),
      ],
    );
  }
}

/// Cards in pairs on a tablet, like the web dashboard's grid.
class _TwoColumns extends StatelessWidget {
  const _TwoColumns({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < children.length; i += 2) ...[
        // Top-aligned rather than stretched: the treemap sizes itself with a
        // LayoutBuilder, which cannot report an intrinsic height.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: children[i]),
            const SizedBox(width: AppSpace.lg),
            Expanded(child: i + 1 < children.length ? children[i + 1] : const SizedBox()),
          ],
        ),
        const SizedBox(height: AppSpace.lg),
      ],
    ],
  );
}

class _HomeSkeleton extends StatelessWidget {
  const _HomeSkeleton();

  @override
  Widget build(BuildContext context) => const Shimmer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SkeletonBox(height: 190, radius: AppRadius.md),
        SizedBox(height: AppSpace.md),
        Row(
          children: [
            Expanded(child: SkeletonBox(height: 64, radius: AppRadius.md)),
            SizedBox(width: AppSpace.md),
            Expanded(child: SkeletonBox(height: 64, radius: AppRadius.md)),
          ],
        ),
        SizedBox(height: AppSpace.lg),
        SkeletonBox(height: 300, radius: AppRadius.md),
      ],
    ),
  );
}
