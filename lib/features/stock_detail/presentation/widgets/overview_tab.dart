import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/key_stats_card.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/position_card.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/prediction_card.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/price_chart_card.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/tab_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The chart, the user's position, key levels and the direction outlook.
class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final held = context.select<StockDetailViewModel, bool>((vm) => vm.holding != null);
    // Key stats read the same request as the chart, which already shows any
    // failure with Retry: one error card on screen, not two.
    final technicalsFailed = context.select<StockDetailViewModel, bool>(
      (vm) => vm.technicals.state is ViewError,
    );
    return TabLayout(
      children: [
        (Pane.main, const PriceChartCard()),
        if (held) (Pane.side, const PositionCard()),
        if (!technicalsFailed) (Pane.side, const KeyStatsCard()),
        (Pane.main, const PredictionCard()),
      ],
    );
  }
}
