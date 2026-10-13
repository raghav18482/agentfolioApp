import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Opens a holding's full screen: chart, position, research and AI.
void openStock(BuildContext context, String symbol, {required String trackId}) {
  context.trackTap(trackId);
  unawaited(context.push(Routes.stockOf(symbol)));
}

/// A holding's numbers at a glance, on long-press: a peek without leaving
/// the list, with a way into the full screen.
Future<void> showHoldingSheet(BuildContext context, Holding holding) {
  HapticFeedback.mediumImpact().ignore();
  context.trackTap('holding_peek');
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    // Sized to its content, not Material's default cap of 9/16 of the
    // screen, which the Open button overflowed on a phone.
    isScrollControlled: true,
    builder: (sheet) => _HoldingSheet(
      holding: holding,
      onOpen: () {
        Navigator.of(sheet).pop();
        openStock(context, holding.symbol, trackId: 'holding_peek_open');
      },
    ),
  );
}

class _HoldingSheet extends StatelessWidget {
  const _HoldingSheet({required this.holding, required this.onOpen});

  final Holding holding;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final h = holding;
    // Scrolls rather than overflows at large text sizes or in landscape.
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text(h.displaySymbol, style: context.text.headlineMedium)),
              PnlPercent(h.pnlPercent, style: context.text.titleMedium),
            ],
          ),
          const SizedBox(height: AppSpace.xs),
          MoneyText(h.pnl, format: MoneyStyle.change, style: context.text.bodyMedium),
          const SizedBox(height: AppSpace.xl),
          _Row(l10n.holdingQuantity, Text(Fmt.number(h.quantity))),
          _Row(l10n.holdingAverage, MoneyText(h.averagePrice)),
          _Row(l10n.holdingLastPrice, MoneyText(h.lastPrice)),
          Divider(height: AppSpace.xl, color: context.palette.border),
          _Row(l10n.homeInvested, MoneyText(h.invested)),
          _Row(l10n.homeCurrentValue, MoneyText(h.currentValue)),
          const SizedBox(height: AppSpace.xl),
          AppButton(
            trackId: 'holding_sheet_open',
            label: l10n.holdingOpenDetails,
            icon: Icons.insights_rounded,
            expand: true,
            onPressed: onOpen,
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Text(label, style: context.text.bodyMedium?.copyWith(color: context.palette.neutral)),
        const Spacer(),
        DefaultTextStyle.merge(style: context.text.titleSmall?.tabular, child: value),
      ],
    ),
  );
}
