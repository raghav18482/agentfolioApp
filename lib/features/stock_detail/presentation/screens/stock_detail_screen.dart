import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/ai_tab.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/fundamentals_tab.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/overview_tab.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/stock_header.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/technicals_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// One stock: price and position up top, then Overview, Fundamentals,
/// Technicals and AI as swipeable tabs. Replaces the web's three separate
/// pages, each with its own stock picker: on a phone, tapping a stock
/// anywhere opens this.
class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: StockTab.values.length, vsync: this)
    ..addListener(_onTabChanged);
  int _reported = 0;

  @override
  void initState() {
    super.initState();
    unawaited(context.read<StockDetailViewModel>().load());
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  /// Runs once the swipe or tap settles on a tab: loads what that tab needs
  /// and reports the change, whichever way the user got there.
  void _onTabChanged() {
    if (_tabs.indexIsChanging || _tabs.index == _reported) return;
    _reported = _tabs.index;
    final tab = StockTab.values[_tabs.index];
    HapticFeedback.selectionClick().ignore();
    context.trackChange('stock_tab', tab.name);
    context.read<StockDetailViewModel>().onTabShown(tab);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: StockHeader(
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabs,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
                dividerColor: context.palette.border,
                indicatorColor: AppColors.brandSoft,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: context.text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: context.text.labelLarge,
                tabs: [
                  Tab(text: l10n.stockTabOverview),
                  Tab(text: l10n.stockTabFundamentals),
                  Tab(text: l10n.stockTabTechnicals),
                  Tab(text: l10n.stockTabAi),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: const [
            StockTabBody(storageKey: 'overview', child: OverviewTab()),
            StockTabBody(storageKey: 'fundamentals', child: FundamentalsTab()),
            StockTabBody(storageKey: 'technicals', child: TechnicalsTab()),
            StockTabBody(storageKey: 'ai', child: AiTab()),
          ],
        ),
      ),
    );
  }
}

/// One tab's scrolling content under the shared collapsing header, with
/// pull-to-refresh. Kept alive when swiped away, so coming back shows it as
/// it was, without replaying its entrance or reloading its charts.
class StockTabBody extends StatefulWidget {
  const StockTabBody({required this.storageKey, required this.child, super.key});

  final String storageKey;

  /// A column of cards. Laid out two-up on wide screens by the tab itself.
  final Widget child;

  @override
  State<StockTabBody> createState() => _StockTabBodyState();
}

class _StockTabBodyState extends State<StockTabBody> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(
      // A fresh context under NestedScrollView, which the overlap handle needs.
      builder: (context) => RefreshIndicator(
        color: AppColors.brandSoft,
        backgroundColor: AppColors.surfaceRaised,
        onRefresh: context.read<StockDetailViewModel>().refresh,
        child: CustomScrollView(
          key: PageStorageKey(widget.storageKey),
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverSafeArea(
              top: false,
              sliver: SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpace.page,
                  AppSpace.lg,
                  AppSpace.page,
                  AppSpace.xxl,
                ),
                sliver: SliverToBoxAdapter(child: widget.child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
