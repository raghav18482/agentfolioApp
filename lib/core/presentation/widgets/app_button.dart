import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppButtonVariant {
  /// The one main action on a screen.
  primary,

  /// Brand moments only: onboarding, "Get started".
  gradient,
  secondary,
  ghost,

  /// Irreversible actions: logout, delete account.
  destructive,
}

enum AppButtonSize { medium, large }

/// The app's button. Every press is reported to telemetry under [trackId].
///
/// It presses down slightly under the finger, gives a light haptic tick, and
/// in [loading] keeps its size while showing progress, so the layout never
/// jumps and a second tap cannot fire the action twice.
class AppButton extends StatefulWidget {
  const AppButton({
    required this.trackId,
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  /// Identifies this button in analytics, e.g. `login_submit`.
  final String trackId;
  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool loading;

  /// Fill the available width (bottom CTAs on phones).
  final bool expand;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  void _handleTap() {
    context.trackTap(widget.trackId);
    HapticFeedback.lightImpact().ignore();
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final style = _ButtonStyle.of(widget.variant);
    final height = widget.size == AppButtonSize.large ? 52.0 : 44.0;
    final textStyle = context.text.labelLarge?.copyWith(color: style.foreground);

    final content = AnimatedSwitcher(
      duration: AppMotion.of(context, AppMotion.short),
      child: widget.loading
          ? SizedBox.square(
              key: const ValueKey('loading'),
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2.2, color: style.foreground),
            )
          : Row(
              key: const ValueKey('label'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18, color: style.foreground),
                  const SizedBox(width: AppSpace.sm),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.loading ? '${widget.label}, in progress' : null,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: AppMotion.of(context, const Duration(milliseconds: 120)),
        curve: AppMotion.standard,
        child: AnimatedOpacity(
          opacity: widget.onPressed == null ? 0.45 : 1,
          duration: AppMotion.of(context, AppMotion.short),
          child: SizedBox(
            height: height,
            width: widget.expand ? double.infinity : null,
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.card,
                side: style.border == null ? BorderSide.none : BorderSide(color: style.border!),
              ),
              clipBehavior: Clip.antiAlias,
              child: Ink(
                decoration: BoxDecoration(color: style.background, gradient: style.gradient),
                child: InkWell(
                  onTap: _enabled ? _handleTap : null,
                  onHighlightChanged: (pressed) => setState(() => _pressed = pressed),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(widthFactor: 1, child: content),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonStyle {
  const _ButtonStyle({required this.foreground, this.background, this.gradient, this.border});

  factory _ButtonStyle.of(AppButtonVariant variant) => switch (variant) {
    AppButtonVariant.primary => const _ButtonStyle(
      foreground: Colors.white,
      background: AppColors.brand,
    ),
    AppButtonVariant.gradient => const _ButtonStyle(
      foreground: Colors.white,
      gradient: AppColors.brandGradient,
    ),
    AppButtonVariant.secondary => const _ButtonStyle(
      foreground: AppColors.textPrimary,
      background: AppColors.surfaceRaised,
      border: AppColors.border,
    ),
    AppButtonVariant.ghost => const _ButtonStyle(foreground: AppColors.brandSoft),
    AppButtonVariant.destructive => _ButtonStyle(
      foreground: AppColors.loss,
      background: AppColors.lossStrong.withValues(alpha: 0.12),
      border: AppColors.lossStrong.withValues(alpha: 0.3),
    ),
  };

  final Color foreground;
  final Color? background;
  final Gradient? gradient;
  final Color? border;
}
