import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/app/shell/tab_actions.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/responsive/window_size.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/app_tile.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/trading/presentation/view_models/live_watch_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/premium_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:agentfolio/features/trading/presentation/widgets/briefing_card.dart';
import 'package:agentfolio/features/trading/presentation/widgets/live_watch_card.dart';
import 'package:agentfolio/features/trading/presentation/widgets/premium_card.dart';
import 'package:agentfolio/features/trading/presentation/widgets/proposals_card.dart';
import 'package:agentfolio/features/trading/presentation/widgets/risk_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// The Trade tab. Premium: proposals to decide on, a live price, the risk
/// profile and the daily brief. Otherwise: what Premium adds, and turning
/// it on.
class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  late final AppLifecycleListener _lifecycle;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => context.read<TradeViewModel>().setForeground(foreground: true),
      onHide: () => context.read<TradeViewModel>().setForeground(foreground: false),
    );
  }

  bool _premiumLoaded = false;

  /// Loads what the current plan needs, once each, after this frame.
  void _loadFor({required bool premium}) {
    if (premium && !_loaded) {
      _loaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        unawaited(context.read<TradeViewModel>().load());
        unawaited(context.read<LiveWatchViewModel>().load());
      });
    } else if (!premium && !_premiumLoaded) {
      _premiumLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(context.read<PremiumViewModel>().load());
      });
    }
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  void _onVisibility(VisibilityInfo info) {
    if (!mounted || !_loaded) return;
    final visible = info.visibleFraction > 0;
    context.read<TradeViewModel>().setVisible(visible: visible);
    context.read<LiveWatchViewModel>().setVisible(visible: visible);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final premium = context.select<SessionProvider, bool>(
      (s) => s.signedIn?.user.premium.registered ?? false,
    );
    final wide = WindowSize.of(context).twoPane;
    _loadFor(premium: premium);

    final Widget body;
    if (!premium) {
      body = ListView(
        padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.sm, AppSpace.page, AppSpace.xxl),
        children: const [
          PremiumCard(),
          SizedBox(height: AppSpace.lg),
          _Tools(premium: false),
        ],
      );
    } else {
      const left = [ProposalsCard(), LiveWatchCard()];
      const right = [RiskProfileCard(), BriefingCard(), _Tools(premium: true)];
      body = RefreshIndicator(
        onRefresh: context.read<TradeViewModel>().refresh,
        child: wide
            ? const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(AppSpace.page),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _Column(children: left)),
                    SizedBox(width: AppSpace.lg),
                    Expanded(flex: 2, child: _Column(children: right)),
                  ],
                ),
              )
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpace.page,
                  AppSpace.sm,
                  AppSpace.page,
                  AppSpace.xxl,
                ),
                children: [
                  for (final card in [...left, ...right]) ...[
                    card,
                    const SizedBox(height: AppSpace.lg),
                  ],
                ],
              ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabTrade),
        titleSpacing: AppSpace.page,
        actions: const [TabActions()],
      ),
      body: VisibilityDetector(
        key: const Key('trade_tab'),
        onVisibilityChanged: _onVisibility,
        child: body,
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (final (i, c) in children.indexed) ...[if (i > 0) const SizedBox(height: AppSpace.lg), c],
    ],
  );
}

class _Tools extends StatelessWidget {
  const _Tools({required this.premium});

  final bool premium;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
      child: Column(
        children: [
          if (premium)
            AppTile(
              trackId: 'trade_chat_agent',
              icon: Icons.forum_outlined,
              iconColor: AppColors.brandSoft,
              title: l10n.tradeChatAgent,
              subtitle: l10n.tradeChatAgentHint,
              onTap: () => context.go(Routes.agentWith(trading: true)),
            ),
          AppTile(
            trackId: 'trade_rebalancer',
            icon: Icons.tune_rounded,
            iconColor: AppColors.sky,
            title: l10n.rebalancerTitle,
            subtitle: l10n.rebalancerHint,
            onTap: () => unawaited(context.push(Routes.rebalancer)),
          ),
        ],
      ),
    );
  }
}
