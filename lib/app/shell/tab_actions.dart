import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The actions every tab's app bar carries: hide balances, and Account.
class TabActions extends StatelessWidget {
  const TabActions({super.key, this.showPrivacy = true});

  final bool showPrivacy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hidden = context.select<PrivacyProvider, bool>((p) => p.hideBalances);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPrivacy)
          AppIconButton(
            trackId: 'toggle_hide_balances',
            icon: hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            tooltip: hidden ? l10n.privacyShowBalances : l10n.privacyHideBalances,
            onPressed: context.read<PrivacyProvider>().toggle,
          ),
        AppIconButton(
          trackId: 'open_account',
          icon: Icons.account_circle_outlined,
          tooltip: l10n.accountTitle,
          onPressed: () => context.push(Routes.account),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
