import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

/// Asks the user to confirm a consequential action from a bottom sheet:
/// reachable with a thumb, dismissible by swiping down (which means "no").
///
/// Resolves to true only when the confirm button was pressed.
Future<bool> showConfirmSheet(
  BuildContext context, {
  required String trackId,
  required String title,
  required String message,
  required String confirmLabel,
  String? cancelLabel,
  bool destructive = false,
}) async {
  final confirmed = await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return Padding(
        padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: context.text.titleLarge),
            const SizedBox(height: AppSpace.sm),
            Text(message, style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpace.xl),
            AppButton(
              trackId: '${trackId}_confirm',
              label: confirmLabel,
              variant: destructive ? AppButtonVariant.destructive : AppButtonVariant.primary,
              expand: true,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            const SizedBox(height: AppSpace.sm),
            AppButton(
              trackId: '${trackId}_cancel',
              label: cancelLabel ?? l10n.commonCancel,
              variant: AppButtonVariant.ghost,
              expand: true,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    },
  );
  return confirmed ?? false;
}
