import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/app/shell/adaptive_shell.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Stands in for a tab until its phase is built.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({required this.tab, super.key});

  final ShellTab tab;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = tab.label(l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          AppIconButton(
            trackId: 'open_account',
            icon: Icons.account_circle_outlined,
            tooltip: l10n.accountTitle,
            onPressed: () => context.push(Routes.account),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: EmptyState(
        icon: tab.selectedIcon,
        title: l10n.comingSoonTitle(title),
        message: l10n.comingSoonBody,
      ),
    );
  }
}
