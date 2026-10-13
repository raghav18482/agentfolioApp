import 'package:flutter/material.dart';

/// Motion tokens (Material 3). Use these, never ad-hoc durations, so the app
/// moves with one rhythm.
abstract final class AppMotion {
  /// Small state changes: a chip selecting, a value flashing.
  static const Duration short = Durations.short4; // 200 ms

  /// Components entering or leaving: sheets, cards, tab content.
  static const Duration medium = Durations.medium2; // 300 ms

  /// Whole-screen transitions and the splash hand-off.
  static const Duration long = Durations.long2; // 500 ms

  static const Curve enter = Easing.emphasizedDecelerate;
  static const Curve exit = Easing.emphasizedAccelerate;
  static const Curve standard = Easing.standard;

  /// Zero when the user has asked the OS to reduce motion.
  static Duration of(BuildContext context, Duration duration) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;
}
