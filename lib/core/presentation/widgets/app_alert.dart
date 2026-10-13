import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum AppAlertVariant { error, warning, info, success }

/// An inline message inside a screen: a form error, a warning the user must
/// read, a security note. Announced to screen readers when it appears.
class AppAlert extends StatelessWidget {
  const AppAlert({
    required this.message,
    super.key,
    this.variant = AppAlertVariant.error,
    this.title,
    this.icon,
    this.action,
  });

  final String message;
  final AppAlertVariant variant;
  final String? title;
  final IconData? icon;

  /// A next step, usually a small `AppButton`.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final (color, defaultIcon) = switch (variant) {
      AppAlertVariant.error => (AppColors.loss, Icons.error_outline_rounded),
      AppAlertVariant.warning => (AppColors.warning, Icons.warning_amber_rounded),
      AppAlertVariant.info => (AppColors.info, Icons.info_outline_rounded),
      AppAlertVariant.success => (AppColors.gain, Icons.check_circle_outline_rounded),
    };

    return Semantics(
      liveRegion: variant == AppAlertVariant.error,
      container: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpace.md + 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppRadius.card,
          border: Border.all(color: color.withValues(alpha: 0.28)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon ?? defaultIcon, size: 20, color: color),
            const SizedBox(width: AppSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(title!, style: context.text.titleSmall?.copyWith(color: color)),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    message,
                    style: context.text.bodySmall?.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.85),
                      height: 1.5,
                    ),
                  ),
                  if (action != null) ...[const SizedBox(height: AppSpace.md), action!],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
