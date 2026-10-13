import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Colours Material's [ColorScheme] has no slot for: gains and losses, the
/// surface ladder, the brand gradient. Read with `context.palette`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.gain,
    required this.loss,
    required this.neutral,
    required this.warning,
    required this.surface,
    required this.surfaceRaised,
    required this.border,
    required this.textMuted,
    required this.brandGradient,
  });

  static const dark = AppPalette(
    gain: AppColors.gain,
    loss: AppColors.loss,
    neutral: AppColors.textSecondary,
    warning: AppColors.warning,
    surface: AppColors.surface,
    surfaceRaised: AppColors.surfaceRaised,
    border: AppColors.border,
    textMuted: AppColors.textMuted,
    brandGradient: AppColors.brandGradient,
  );

  final Color gain;
  final Color loss;
  final Color neutral;
  final Color warning;
  final Color surface;
  final Color surfaceRaised;
  final Color border;
  final Color textMuted;
  final Gradient brandGradient;

  /// Green, red or neutral for a signed number.
  Color pnl(num? value) => switch (value) {
    null || 0 => neutral,
    > 0 => gain,
    _ => loss,
  };

  @override
  AppPalette copyWith({
    Color? gain,
    Color? loss,
    Color? neutral,
    Color? warning,
    Color? surface,
    Color? surfaceRaised,
    Color? border,
    Color? textMuted,
    Gradient? brandGradient,
  }) => AppPalette(
    gain: gain ?? this.gain,
    loss: loss ?? this.loss,
    neutral: neutral ?? this.neutral,
    warning: warning ?? this.warning,
    surface: surface ?? this.surface,
    surfaceRaised: surfaceRaised ?? this.surfaceRaised,
    border: border ?? this.border,
    textMuted: textMuted ?? this.textMuted,
    brandGradient: brandGradient ?? this.brandGradient,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      gain: Color.lerp(gain, other.gain, t)!,
      loss: Color.lerp(loss, other.loss, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      border: Color.lerp(border, other.border, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      brandGradient: t < 0.5 ? brandGradient : other.brandGradient,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
}
