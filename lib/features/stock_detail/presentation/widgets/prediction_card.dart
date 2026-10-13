import 'dart:async';

import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/logic/research_logic.dart';
import 'package:agentfolio/features/research/presentation/research_style.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Where the technical signals lean over a day, a week and a month.
///
/// Labelled honestly: the engine is named (a rule-based score is never
/// presented as a model), and an uncalibrated confidence carries the
/// server's own caveat, verbatim. Loads only once scrolled into view.
class PredictionCard extends StatelessWidget {
  const PredictionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<StockDetailViewModel>();
    final state = context.select<StockDetailViewModel, ViewState<Prediction>>(
      (vm) => vm.prediction.state,
    );

    return VisibilityDetector(
      key: ValueKey('prediction_${vm.symbol}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) unawaited(vm.revealPrediction());
      },
      child: SectionCard(
        title: l10n.predictionTitle,
        subtitle: l10n.predictionSubtitle,
        child: SectionState(
          state: state,
          retryTrackId: 'prediction_retry',
          onRetry: () => unawaited(vm.prediction.load(force: true)),
          skeleton: const Column(
            children: [
              SkeletonBox(width: double.infinity, height: 44),
              SizedBox(height: AppSpace.md),
              SkeletonBox(width: double.infinity, height: 120),
            ],
          ),
          builder: (context, data) => _Body(data: data),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.data});

  final Prediction data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final leaning = leaningOfOutlook(data.outlook);
    final color = ResearchStyle.leaning(leaning);
    final version = shownModelVersion(data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // No overall percentage beside the outlook: it is the average lean
        // (probability − 0.5), and "Bearish −9.7%" reads as a forecast price
        // move. The horizons below carry the real figures.
        Row(
          children: [
            Icon(_icon(leaning), color: color, size: 28),
            const SizedBox(width: AppSpace.xs),
            Flexible(
              child: Text(
                _outlookLabel(l10n, data.outlook),
                style: context.text.titleLarge?.copyWith(color: color, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.sm),
        // The engine, named on its own line so it is never squeezed out.
        Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            version == null ? l10n.predictionEngineRules : l10n.predictionEngineModel(version),
            icon: version == null ? Icons.rule_rounded : Icons.memory_rounded,
          ),
        ),
        if (data.needsCalibrationNotice) ...[
          const SizedBox(height: AppSpace.md),
          AppAlert(
            variant: AppAlertVariant.warning,
            message: data.disclaimer ?? Disclaimers.predictionCalibration,
          ),
        ],
        const SizedBox(height: AppSpace.lg),
        for (final h in Horizon.values)
          if (data.calls[h] case final call?)
            _HorizonRow(label: _horizonLabel(l10n, h), call: call),
        const SizedBox(height: AppSpace.md),
        Divider(color: context.palette.border, height: 1),
        const SizedBox(height: AppSpace.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Signals(
                title: l10n.predictionPushingUp,
                signals: data.bullishSignals,
                color: AppColors.gain,
              ),
            ),
            const SizedBox(width: AppSpace.lg),
            Expanded(
              child: _Signals(
                title: l10n.predictionPushingDown,
                signals: data.bearishSignals,
                color: AppColors.loss,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// One horizon: its call, and a meter from bearish to bullish with the
/// neutral 45–55 band marked, so the strength reads at a glance.
class _HorizonRow extends StatelessWidget {
  const _HorizonRow({required this.label, required this.call});

  final String label;
  final HorizonCall call;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final up = upwardPercent(call);
    final leaning = leaningOfDirection(call.direction);
    final color = ResearchStyle.leaning(leaning);
    return Semantics(
      label: l10n.predictionHorizonSemantics(
        label,
        _directionLabel(l10n, call.direction),
        (call.confidence * 100).toStringAsFixed(0),
      ),
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.md),
        child: Row(
          children: [
            SizedBox(width: 64, child: Text(label, style: context.text.labelLarge)),
            SizedBox(
              width: 82,
              child: Row(
                children: [
                  Icon(_icon(leaning), size: 20, color: color),
                  Flexible(
                    child: Text(
                      _directionLabel(l10n, call.direction),
                      style: context.text.labelLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _Meter(percent: up, color: color),
            ),
            const SizedBox(width: AppSpace.sm),
            SizedBox(
              width: 40,
              child: Text(
                '${(call.confidence * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.end,
                style: context.text.labelMedium?.tabular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Meter extends StatelessWidget {
  const _Meter({required this.percent, required this.color});

  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final w = c.maxWidth;
      return SizedBox(
        height: 12,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: context.palette.surfaceRaised,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // The neutral band.
            Positioned(
              left: w * 0.45,
              width: w * 0.10,
              child: Container(height: 4, color: AppColors.warning.withValues(alpha: 0.35)),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 50, end: percent),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, p, _) => Positioned(
                left: (w - 12) * (p / 100).clamp(0, 1),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _Signals extends StatelessWidget {
  const _Signals({required this.title, required this.signals, required this.color});

  final String title;
  final List<PredictionSignal> signals;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: context.text.labelSmall?.copyWith(color: color)),
        const SizedBox(height: AppSpace.sm),
        if (signals.isEmpty)
          Text(l10n.predictionNoSignals, style: context.text.bodySmall)
        else
          for (final s in signals)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(s.feature, style: context.text.bodySmall)),
                  const SizedBox(width: AppSpace.xs),
                  Text(
                    s.value == null ? '—' : '${s.value! > 0 ? '+' : ''}${s.value}',
                    style: context.text.labelMedium?.tabular.copyWith(color: color),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

IconData _icon(Leaning l) => switch (l) {
  Leaning.bullish => Icons.arrow_drop_up_rounded,
  Leaning.bearish => Icons.arrow_drop_down_rounded,
  Leaning.neutral => Icons.remove_rounded,
};

String _outlookLabel(AppLocalizations l10n, Outlook o) => switch (o) {
  Outlook.bullish => l10n.outlookBullish,
  Outlook.bearish => l10n.outlookBearish,
  Outlook.neutral => l10n.outlookNeutral,
};

String _directionLabel(AppLocalizations l10n, Direction d) => switch (d) {
  Direction.up => l10n.directionUp,
  Direction.down => l10n.directionDown,
  Direction.neutral => l10n.directionNeutral,
};

String _horizonLabel(AppLocalizations l10n, Horizon h) => switch (h) {
  Horizon.day => l10n.horizonDay,
  Horizon.week => l10n.horizonWeek,
  Horizon.month => l10n.horizonMonth,
};
