import 'package:flutter/painting.dart';

/// The palette. The only file allowed raw colour values.
///
/// Surfaces come from the app icon's slate navy, so the native splash, the
/// animated splash and the first screen share one background. Brand and
/// semantic colours match the web app's Tailwind `@theme` tokens.
abstract final class AppColors {
  // Surfaces, darkest to lightest.
  static const background = Color(0xFF0F172A);
  static const surface = Color(0xFF151F35);
  static const surfaceRaised = Color(0xFF1C2742);
  static const surfaceHighest = Color(0xFF243150);
  static const border = Color(0xFF26324D);
  static const borderStrong = Color(0xFF334155);

  // Text
  static const textPrimary = Color(0xFFF1F5F9);
  static const textSecondary = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF64748B);

  // Brand (web: brand-*)
  static const brand = Color(0xFF4F46E5);
  static const brandBright = Color(0xFF6366F1);
  static const brandSoft = Color(0xFF818CF8);

  // The icon's signature sweep: emerald → sky → indigo.
  static const emerald = Color(0xFF10B981);
  static const sky = Color(0xFF0EA5E9);
  static const indigo = Color(0xFF6366F1);
  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, sky, indigo],
  );

  // Semantic
  static const gain = Color(0xFF34D399);
  static const gainStrong = Color(0xFF10B981);
  static const loss = Color(0xFFFB7185);
  static const lossStrong = Color(0xFFF43F5E);
  static const warning = Color(0xFFFBBF24);
  static const warningStrong = Color(0xFFF59E0B);
  static const info = Color(0xFF38BDF8);

  // Grade steps between gain and loss (web: lime-400, orange-400), and the
  // second indicator line on charts.
  static const lime = Color(0xFFA3E635);
  static const orange = Color(0xFFFB923C);
}
