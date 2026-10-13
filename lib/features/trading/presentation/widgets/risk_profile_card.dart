import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

String goalLabel(AppLocalizations l10n, InvestmentGoal g) => switch (g) {
  InvestmentGoal.wealthCreation => l10n.goalWealth,
  InvestmentGoal.income => l10n.goalIncome,
  InvestmentGoal.preservation => l10n.goalPreservation,
  InvestmentGoal.speculation => l10n.goalSpeculation,
};

String toleranceLabel(AppLocalizations l10n, RiskTolerance t) => switch (t) {
  RiskTolerance.low => l10n.toleranceLow,
  RiskTolerance.medium => l10n.toleranceMedium,
  RiskTolerance.high => l10n.toleranceHigh,
};

String productLabel(AppLocalizations l10n, ProductType p) => switch (p) {
  ProductType.delivery => l10n.productDelivery,
  ProductType.intraday => l10n.productIntraday,
};

/// The limits every proposal is checked against before it reaches the
/// broker. No profile, no checks: so setting one up comes first.
class RiskProfileCard extends StatelessWidget {
  const RiskProfileCard({super.key});

  Future<void> _edit(BuildContext context, RiskProfile? current) async {
    final vm = context.read<TradeViewModel>();
    await context.push(Routes.tradeProfile, extra: current);
    await vm.profile.load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<TradeViewModel>();
    final current = vm.profile.data;

    return SectionCard(
      title: l10n.profileTitle,
      subtitle: l10n.profileSubtitle,
      trailing: current == null
          ? null
          : TextButton(
              onPressed: () => unawaited(_edit(context, current)),
              child: Text(l10n.profileEdit),
            ),
      child: SectionState<RiskProfile?>(
        state: vm.profile.state,
        retryTrackId: 'profile_retry',
        onRetry: () => unawaited(vm.profile.load(force: true)),
        skeletonHeight: 100,
        builder: (context, profile) => profile == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.profileNone,
                    style: context.text.bodyMedium?.copyWith(
                      color: AppColors.warning,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: AppSpace.md),
                  AppButton(
                    trackId: 'profile_set_up',
                    label: l10n.profileSetUp,
                    icon: Icons.shield_outlined,
                    onPressed: () => unawaited(_edit(context, null)),
                  ),
                ],
              )
            : _Summary(profile: profile),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.profile});

  final RiskProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      (l10n.profileAge, '${profile.age}'),
      (l10n.profileGoal, goalLabel(l10n, profile.goal)),
      (l10n.profileHorizon, l10n.profileYears(profile.horizonYears)),
      (l10n.profileTolerance, toleranceLabel(l10n, profile.tolerance)),
      (l10n.profileTax, profile.taxBracket.isEmpty ? Fmt.missing : profile.taxBracket),
      (l10n.profileMaxOrder, Fmt.rupees(profile.maxOrderValue)),
      (l10n.profileMaxPosition, '${Fmt.number(profile.maxPositionPercent)}%'),
      (l10n.profileMaxTrades, '${profile.maxDailyTrades}'),
      (
        l10n.profileProducts,
        [
          for (final p in ProductType.values)
            if (profile.products.contains(p)) productLabel(l10n, p),
        ].join(', '),
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 480 ? 3 : 2;
        final width = (constraints.maxWidth - AppSpace.lg * (columns - 1)) / columns;
        return Wrap(
          spacing: AppSpace.lg,
          runSpacing: AppSpace.md,
          children: [
            for (final (label, value) in items)
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: context.text.labelSmall),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
