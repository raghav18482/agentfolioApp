import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/logic/research_logic.dart';
import 'package:flutter/material.dart';

/// Colours and words for research verdicts, shared by Stock Detail and
/// Learn so a "good" reads the same everywhere.
abstract final class ResearchStyle {
  static Color verdict(Verdict v) => switch (v) {
    Verdict.good => AppColors.gain,
    Verdict.bad => AppColors.loss,
    Verdict.neutral => AppColors.warning,
    Verdict.excluded || Verdict.unknown => AppColors.textMuted,
  };

  static String verdictLabel(AppLocalizations l10n, Verdict v) => switch (v) {
    Verdict.good => l10n.verdictGood,
    Verdict.bad => l10n.verdictBad,
    Verdict.neutral => l10n.verdictNeutral,
    Verdict.excluded => l10n.verdictExcluded,
    Verdict.unknown => l10n.verdictUnknown,
  };

  /// A to E, green to red. A provisional score is grey instead: colour is
  /// what a beginner reads first, and it must not overstate a thin reading.
  static Color grade(String? grade, {bool provisional = false}) {
    if (provisional) return AppColors.textSecondary;
    return switch (grade) {
      'A' => AppColors.gain,
      'B' => AppColors.lime,
      'C' => AppColors.warning,
      'D' => AppColors.orange,
      'E' => AppColors.loss,
      _ => AppColors.warning,
    };
  }

  static Color leaning(Leaning l) => switch (l) {
    Leaning.bullish => AppColors.gain,
    Leaning.bearish => AppColors.loss,
    Leaning.neutral => AppColors.warning,
  };

  static Color signal(SignalStatus s) => switch (s) {
    SignalStatus.bullish => AppColors.gain,
    SignalStatus.bearish => AppColors.loss,
    SignalStatus.neutral => AppColors.textSecondary,
  };

  /// Never colour alone: every status also carries a shape.
  static IconData signalIcon(SignalStatus s) => switch (s) {
    SignalStatus.bullish => Icons.arrow_drop_up_rounded,
    SignalStatus.bearish => Icons.arrow_drop_down_rounded,
    SignalStatus.neutral => Icons.circle,
  };
}
