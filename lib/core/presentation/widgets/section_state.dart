import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

/// `AsyncView`'s compact sibling, for one section inside a card: a skeleton
/// of the content's height, an inline error with Retry, or the data.
///
/// An [UnavailableFailure] (an ETF with no fundamentals, a stock too new for
/// indicators) is a calm note without Retry, since retrying cannot help.
class SectionState<T> extends StatelessWidget {
  const SectionState({
    required this.state,
    required this.builder,
    required this.onRetry,
    required this.retryTrackId,
    super.key,
    this.skeletonHeight = 160,
    this.skeleton,
    this.unavailableHint,
  });

  final ViewState<T> state;
  final Widget Function(BuildContext context, T data) builder;
  final VoidCallback onRetry;
  final String retryTrackId;
  final double skeletonHeight;

  /// A custom placeholder shaped like the content. Shimmered for you.
  final Widget? skeleton;

  /// Why this section can be unavailable, in plain words, shown above the
  /// server's own (often technical) reason.
  final String? unavailableHint;

  @override
  Widget build(BuildContext context) {
    final placeholder = skeleton ?? SkeletonBox(width: double.infinity, height: skeletonHeight);
    final (Key key, Widget child) = switch (state) {
      // Idle: not asked for yet (scrolled out of view). Still, not shimmering.
      ViewIdle<T>() => (const ValueKey('idle'), placeholder),
      ViewLoading<T>() => (const ValueKey('loading'), Shimmer(child: placeholder)),
      ViewError<T>(:final failure) => (
        const ValueKey('error'),
        SectionFailure(
          failure: failure,
          onRetry: onRetry,
          retryTrackId: retryTrackId,
          unavailableHint: unavailableHint,
        ),
      ),
      ViewData<T>(:final data) => (const ValueKey('data'), builder(context, data)),
    };
    return AnimatedSwitcher(
      duration: AppMotion.of(context, AppMotion.medium),
      switchInCurve: AppMotion.enter,
      switchOutCurve: AppMotion.exit,
      layoutBuilder: (current, previous) =>
          Stack(alignment: Alignment.topCenter, children: [...previous, ?current]),
      child: KeyedSubtree(key: key, child: child),
    );
  }
}

/// A failure inside a card: "not available" calmly, anything else with Retry.
class SectionFailure extends StatelessWidget {
  const SectionFailure({
    required this.failure,
    required this.onRetry,
    required this.retryTrackId,
    super.key,
    this.unavailableHint,
  });

  final Failure failure;
  final VoidCallback onRetry;
  final String retryTrackId;
  final String? unavailableHint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (failure is UnavailableFailure) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline_rounded, size: 20, color: AppColors.textMuted),
            const SizedBox(width: AppSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.unavailableTitle, style: context.text.titleSmall),
                  if (unavailableHint != null) ...[
                    const SizedBox(height: AppSpace.xs),
                    Text(unavailableHint!, style: context.text.bodyMedium?.copyWith(height: 1.45)),
                  ],
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    failure.message,
                    style: context.text.labelSmall?.copyWith(
                      color: context.palette.textMuted,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return AppAlert(
      message: failure.message,
      variant: failure is NetworkFailure || failure is TimeoutFailure
          ? AppAlertVariant.warning
          : AppAlertVariant.error,
      action: AppButton(
        trackId: retryTrackId,
        label: l10n.commonRetry,
        icon: Icons.refresh_rounded,
        size: AppButtonSize.medium,
        variant: AppButtonVariant.secondary,
        onPressed: onRetry,
      ),
    );
  }
}
