import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:flutter/material.dart';

/// A failed load with nothing to show: what went wrong, in plain words, and
/// a way to try again.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.failure,
    required this.onRetry,
    required this.retryTrackId,
    super.key,
  });

  final Failure failure;
  final VoidCallback onRetry;
  final String retryTrackId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (failure is UnavailableFailure) {
      // Nothing to retry: the server has no data for this, and says why.
      return EmptyState(
        icon: Icons.info_outline_rounded,
        iconColor: AppColors.textSecondary,
        title: l10n.unavailableTitle,
        message: failure.message,
      );
    }
    // A timeout reached the server, which was slow: not "can't reach".
    final (icon, color, title) = switch (failure) {
      NetworkFailure() => (Icons.wifi_off_rounded, AppColors.warning, l10n.splashOfflineTitle),
      TimeoutFailure() => (Icons.hourglass_bottom_rounded, AppColors.warning, l10n.commonTooSlow),
      _ => (Icons.error_outline_rounded, AppColors.loss, l10n.commonSomethingWrong),
    };
    return EmptyState(
      icon: icon,
      iconColor: color,
      title: title,
      message: failure.message,
      action: AppButton(
        trackId: retryTrackId,
        label: l10n.commonRetry,
        icon: Icons.refresh_rounded,
        variant: AppButtonVariant.secondary,
        size: AppButtonSize.medium,
        onPressed: onRetry,
      ),
    );
  }
}
