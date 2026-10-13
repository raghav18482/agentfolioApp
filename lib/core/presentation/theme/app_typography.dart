import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Inter for reading, Space Grotesk for headings and big numbers, as on the
/// web. Until the font files are bundled, the platform font stands in.
abstract final class AppTypography {
  static const body = 'Inter';
  static const display = 'SpaceGrotesk';

  /// Digits of equal width, so columns of prices line up and a ticking price
  /// does not jitter sideways.
  static const tabular = [FontFeature.tabularFigures()];

  static TextTheme textTheme() {
    const primary = AppColors.textPrimary;
    const secondary = AppColors.textSecondary;
    TextStyle display0(double size, FontWeight weight, {double height = 1.15}) => TextStyle(
      fontFamily: display,
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: primary,
      letterSpacing: -0.4,
    );
    TextStyle body0(double size, FontWeight weight, Color color, {double height = 1.45}) =>
        TextStyle(
          fontFamily: body,
          fontSize: size,
          fontWeight: weight,
          height: height,
          color: color,
        );

    return TextTheme(
      displayLarge: display0(40, FontWeight.w700),
      displayMedium: display0(32, FontWeight.w700),
      displaySmall: display0(28, FontWeight.w700),
      headlineLarge: display0(26, FontWeight.w700),
      headlineMedium: display0(22, FontWeight.w700),
      headlineSmall: display0(20, FontWeight.w600),
      titleLarge: display0(18, FontWeight.w600, height: 1.3),
      titleMedium: body0(16, FontWeight.w600, primary, height: 1.35),
      titleSmall: body0(14, FontWeight.w600, primary, height: 1.35),
      bodyLarge: body0(16, FontWeight.w400, primary),
      bodyMedium: body0(14, FontWeight.w400, primary),
      bodySmall: body0(12.5, FontWeight.w400, secondary),
      labelLarge: body0(14, FontWeight.w600, primary, height: 1.2),
      labelMedium: body0(12.5, FontWeight.w500, secondary, height: 1.2),
      labelSmall: body0(11, FontWeight.w600, secondary, height: 1.2).copyWith(letterSpacing: 0.6),
    );
  }
}

extension NumericText on TextStyle {
  /// This style with tabular figures, for any number that changes or aligns.
  TextStyle get tabular => copyWith(fontFeatures: AppTypography.tabular);
}
