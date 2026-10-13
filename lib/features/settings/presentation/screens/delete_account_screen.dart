import 'dart:async';

import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/settings/presentation/view_models/delete_account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Permanently deletes the Agentfolio account. Says exactly what goes and
/// what stays, then asks for the app password and a final confirmation.
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<DeleteAccountViewModel>();
    FocusScope.of(context).unfocus();
    if (!vm.validate(_password.text)) return;
    final confirmed = await showConfirmSheet(
      context,
      trackId: 'delete_account_confirm',
      title: l10n.deleteFinalTitle,
      message: l10n.deleteFinalBody,
      confirmLabel: l10n.deleteFinalConfirm,
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    // On success the session ends and the router moves on to Login.
    await vm.delete(_password.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<DeleteAccountViewModel>();
    final active = context.select<SessionProvider, BrokerAccount?>((s) => s.activeAccount);
    final account = active?.clientCode;
    final broker = context.read<BrokerRegistry>().resolve(active?.brokerId).displayName;
    final failure = vm.failure;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.deleteTitle)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.page,
            AppSpace.sm,
            AppSpace.page,
            AppSpace.xxl,
          ),
          children: [
            Text(
              l10n.deleteIntro,
              style: context.text.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
            _Section(
              title: l10n.deleteGoesTitle,
              icon: Icons.delete_outline_rounded,
              color: AppColors.loss,
              points: [
                l10n.deleteGoesAccount,
                l10n.deleteGoesCredentials(broker),
                l10n.deleteGoesChats,
                l10n.deleteGoesSettings,
                l10n.deleteGoesDevice,
              ],
            ),
            _Section(
              title: l10n.deleteStaysTitle,
              icon: Icons.inventory_2_outlined,
              color: AppColors.textSecondary,
              points: [l10n.deleteStaysBroker(broker, account ?? ''), l10n.deleteStaysAudit],
            ),
            const SizedBox(height: AppSpace.xl),
            if (failure != null && !vm.passwordWrong) ...[
              AppAlert(message: failure.message),
              const SizedBox(height: AppSpace.lg),
            ],
            AppTextField(
              controller: _password,
              label: l10n.deletePassword,
              secret: true,
              trackId: 'delete_password',
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.done,
              error: vm.passwordMissing
                  ? l10n.deletePasswordMissing
                  : vm.passwordWrong
                  ? failure!.message
                  : null,
              onChanged: (_) => vm.clearErrors(),
            ),
            const SizedBox(height: AppSpace.md),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: vm.understood,
              onChanged: (v) => vm.setUnderstood(value: v ?? false),
              title: Text(l10n.deleteUnderstand),
              subtitle: vm.notAcknowledged
                  ? Text(
                      l10n.deleteUnderstandMissing,
                      style: const TextStyle(color: AppColors.loss),
                    )
                  : null,
            ),
            const SizedBox(height: AppSpace.lg),
            AppButton(
              trackId: 'delete_account_submit',
              label: l10n.deleteSubmit,
              icon: Icons.delete_forever_rounded,
              variant: AppButtonVariant.destructive,
              loading: vm.submitting,
              onPressed: () => unawaited(_submit()),
            ),
            if (failure is RateLimitedFailure) ...[
              const SizedBox(height: AppSpace.md),
              Text(
                l10n.deleteThrottled,
                style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpace.xl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: AppSpace.sm),
            Text(title.toUpperCase(), style: context.text.labelSmall),
          ],
        ),
        const SizedBox(height: AppSpace.sm),
        for (final p in points)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8, right: AppSpace.md),
                  child: Icon(Icons.circle, size: 5, color: AppColors.textSecondary),
                ),
                Expanded(child: Text(p, style: context.text.bodyMedium?.copyWith(height: 1.45))),
              ],
            ),
          ),
      ],
    ),
  );
}
