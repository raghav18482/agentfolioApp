import 'dart:async';

import 'package:agentfolio/app/shell/tab_actions.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/features/markets/presentation/view_models/markets_view_model.dart';
import 'package:agentfolio/features/markets/presentation/widgets/news_view.dart';
import 'package:agentfolio/features/markets/presentation/widgets/sectors_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Markets: News (for the sectors the user holds, plus search) and Sectors
/// (the market's breadth, and the user's sectors against their indices).
class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<MarketsViewModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<MarketsViewModel>();
    final view = context.select<MarketsViewModel, MarketsView>((vm) => vm.view);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabMarkets),
        titleSpacing: AppSpace.page,
        actions: const [TabActions()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.xs, AppSpace.page, 0),
            child: AppSegmented<MarketsView>(
              trackId: 'markets_view',
              selected: view,
              onChanged: vm.selectView,
              segments: [
                AppSegment(value: MarketsView.news, label: l10n.marketsNews, id: 'news'),
                AppSegment(value: MarketsView.sectors, label: l10n.marketsSectors, id: 'sectors'),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: AppMotion.of(context, AppMotion.medium),
              switchInCurve: AppMotion.enter,
              child: KeyedSubtree(
                key: ValueKey(view),
                child: switch (view) {
                  MarketsView.news => const NewsView(),
                  MarketsView.sectors => const SectorsView(),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
