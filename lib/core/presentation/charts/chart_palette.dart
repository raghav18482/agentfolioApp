import 'dart:ui';

import 'package:agentfolio/core/presentation/theme/app_colors.dart';

/// Colours for charts. Ported from the web app's `components/charts/theme.ts`
/// so a sector or a P&L tile is the same colour on both.
abstract final class ChartPalette {
  static const categories = [
    Color(0xFF6366F1),
    Color(0xFF22C55E),
    Color(0xFFF97316),
    Color(0xFF06B6D4),
    Color(0xFFEC4899),
    Color(0xFFEAB308),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
    Color(0xFFF43F5E),
    Color(0xFF0EA5E9),
    Color(0xFFA855F7),
    Color(0xFF84CC16),
    Color(0xFFEF4444),
    Color(0xFF64748B),
    Color(0xFFD946EF),
  ];

  static Color category(int index) => categories[index % categories.length];

  static const Color nifty = AppColors.warning;
  static const Color portfolio = AppColors.gainStrong;
  static const grid = Color(0x1494A3B8);

  /// A tile colour for a P&L, deeper the bigger the move. [intensity] is the
  /// move relative to the biggest one on screen, 0–1.
  static Color pnl(double value, double intensity) {
    final t = intensity.abs().clamp(0.0, 1.0);
    if (value > 0) {
      return Color.fromARGB(
        255,
        (15 + t * 19).round(),
        (20 + t * 177).round(),
        (25 + t * 69).round(),
      );
    }
    if (value < 0) {
      return Color.fromARGB(
        255,
        (60 + t * 179).round(),
        (20 + t * 20).round(),
        (25 + t * 43).round(),
      );
    }
    return AppColors.surfaceHighest;
  }
}
