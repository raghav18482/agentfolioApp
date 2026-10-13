import 'dart:async';
import 'dart:math' as math;

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/logic/research_logic.dart';
import 'package:agentfolio/features/research/presentation/research_style.dart';
import 'package:agentfolio/features/research/presentation/widgets/metric_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The 0–100 fundamental score: a ring, its grade, how much data it rests
/// on, and the four pillars, each opening to the metrics it graded.
class ScoreCard extends StatelessWidget {
  const ScoreCard({required this.score, super.key, this.sector, this.industry});

  final FundamentalScore? score;
  final String? sector;
  final String? industry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = score;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(l10n.scoreTitle, style: context.text.titleMedium)),
              Flexible(
                child: _LinkText(
                  label: l10n.scoreHowCalculated,
                  trackId: 'score_how_calculated',
                  onTap: () => unawaited(context.push(Routes.learnAt(Routes.learnScoringAnchor))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(l10n.scoreSubtitle, style: context.text.bodySmall),
          if (sector != null || industry != null) ...[
            const SizedBox(height: AppSpace.sm),
            Wrap(
              spacing: AppSpace.xs,
              runSpacing: AppSpace.xs,
              children: [
                if (sector != null) StatusChip(sector!),
                if (industry != null && industry != sector) StatusChip(industry!),
              ],
            ),
          ],
          const SizedBox(height: AppSpace.lg),
          if (s == null || !s.isScored)
            _Unscored(note: s?.note ?? l10n.scoreNoData)
          else
            _Scored(score: s),
        ],
      ),
    );
  }
}

class _Unscored extends StatelessWidget {
  const _Unscored({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpace.lg),
    decoration: BoxDecoration(
      borderRadius: AppRadius.card,
      border: Border.all(color: context.palette.border),
    ),
    child: Text(note, style: context.text.bodySmall, textAlign: TextAlign.center),
  );
}

class _Scored extends StatelessWidget {
  const _Scored({required this.score});

  final FundamentalScore score;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = ResearchStyle.grade(score.grade, provisional: score.isProvisional);
    final skipped = skippedParts(score);
    final skippedText = [
      for (final p in skipped.pillars) l10n.scoreSkippedPillar(p.toLowerCase()),
      ...skipped.metrics,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _ScoreRing(total: score.total!, color: color),
            const SizedBox(width: AppSpace.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip(
                    score.isProvisional
                        ? l10n.scoreProvisional(score.grade ?? '')
                        : l10n.scoreGradeLabel(score.grade ?? '', score.label),
                    color: color,
                  ),
                  if (score.confidence == ScoreConfidence.medium ||
                      score.confidence == ScoreConfidence.low) ...[
                    const SizedBox(height: AppSpace.sm),
                    Text(
                      score.confidence == ScoreConfidence.low
                          ? l10n.scoreConfidenceLow(score.metricsUsed, score.metricsTotal)
                          : l10n.scoreConfidenceMedium(score.metricsUsed, score.metricsTotal),
                      style: context.text.bodySmall?.copyWith(
                        color: score.confidence == ScoreConfidence.medium
                            ? AppColors.warning
                            : context.palette.neutral,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        if (skippedText.isNotEmpty) ...[
          const SizedBox(height: AppSpace.md),
          Text(l10n.scoreAdjusted(skippedText.join(', ')), style: context.text.bodySmall),
        ],
        const SizedBox(height: AppSpace.lg),
        for (final p in score.pillars) _PillarTile(pillar: p, color: color),
        if (score.strengths.isNotEmpty || score.concerns.isNotEmpty)
          const SizedBox(height: AppSpace.md),
        if (score.strengths.isNotEmpty)
          _Notes(heading: l10n.scoreStrengths, items: score.strengths, color: AppColors.gain),
        if (score.concerns.isNotEmpty)
          _Notes(heading: l10n.scoreConcerns, items: score.concerns, color: AppColors.loss),
        const SizedBox(height: AppSpace.md),
        Text(
          Disclaimers.scoreLimits,
          style: context.text.labelSmall?.copyWith(letterSpacing: 0, height: 1.5),
        ),
      ],
    );
  }
}

/// The score in a ring that sweeps to it, counting up as it goes.
class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.total, required this.color});

  final double total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      label: l10n.scoreSemantics(total.round()),
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: total.clamp(0, 100)),
        duration: AppMotion.of(context, const Duration(milliseconds: 900)),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) => SizedBox.square(
          dimension: 104,
          child: CustomPaint(
            painter: _RingPainter(fraction: value / 100, color: color),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.round().toString(),
                    style: context.text.headlineMedium?.tabular.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Text(l10n.scoreOutOf, style: context.text.labelSmall),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.fraction, required this.color});

  final double fraction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 9.0;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    Paint arc(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, math.pi * 2, false, arc(AppColors.surfaceRaised));
    if (fraction > 0) {
      canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * fraction, false, arc(color));
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.fraction != fraction || old.color != color;
}

/// A pillar's points as a bar; tap to see the metrics it graded, each with
/// its verdict and the scorer's note.
class _PillarTile extends StatefulWidget {
  const _PillarTile({required this.pillar, required this.color});

  final ScorePillar pillar;
  final Color color;

  @override
  State<_PillarTile> createState() => _PillarTileState();
}

class _PillarTileState extends State<_PillarTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = widget.pillar;
    final duration = AppMotion.of(context, AppMotion.medium);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          expanded: _open,
          child: InkWell(
            borderRadius: const BorderRadius.all(AppRadius.sm),
            onTap: p.metrics.isEmpty
                ? null
                : () {
                    context.trackChange('score_pillar_${p.key}', _open ? 'closed' : 'open');
                    setState(() => _open = !_open);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(p.label, style: context.text.titleSmall)),
                      Text(
                        p.score == null
                            ? l10n.scorePillarNoData
                            : l10n.scorePillarPoints(Fmt.number(p.score), Fmt.number(p.max)),
                        style: context.text.labelMedium?.tabular,
                      ),
                      if (p.metrics.isNotEmpty)
                        AnimatedRotation(
                          turns: _open ? 0.5 : 0,
                          duration: duration,
                          child: const Icon(
                            Icons.expand_more_rounded,
                            size: 20,
                            color: AppColors.textMuted,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: p.fraction),
                      duration: AppMotion.of(context, const Duration(milliseconds: 800)),
                      curve: Curves.easeOutCubic,
                      builder: (context, v, _) => LinearProgressIndicator(
                        value: v,
                        minHeight: 6,
                        color: widget.color,
                        backgroundColor: context.palette.surfaceRaised,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(p.tagline, style: context.text.labelSmall?.copyWith(letterSpacing: 0)),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: duration,
          curve: AppMotion.enter,
          alignment: Alignment.topCenter,
          child: !_open
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(left: AppSpace.sm, bottom: AppSpace.sm),
                  child: Column(children: [for (final m in p.metrics) _GradedMetric(metric: m)]),
                ),
        ),
      ],
    );
  }
}

class _GradedMetric extends StatelessWidget {
  const _GradedMetric({required this.metric});

  final ScoreMetric metric;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(top: 6), child: VerdictDot(metric.verdict)),
        const SizedBox(width: AppSpace.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(metric.label, style: context.text.bodyMedium)),
                  Text(metric.display, style: context.text.labelLarge?.tabular),
                ],
              ),
              if (metric.note.isNotEmpty)
                Text(
                  metric.note,
                  style: context.text.labelSmall?.copyWith(
                    letterSpacing: 0,
                    color: ResearchStyle.verdict(metric.verdict),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Notes extends StatelessWidget {
  const _Notes({required this.heading, required this.items, required this.color});

  final String heading;
  final List<String> items;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: AppSpace.sm),
    padding: const EdgeInsets.all(AppSpace.md),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: AppRadius.card,
      border: Border.all(color: color.withValues(alpha: 0.22)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading.toUpperCase(), style: context.text.labelSmall?.copyWith(color: color)),
        const SizedBox(height: AppSpace.xs),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•  ', style: context.text.bodySmall?.copyWith(color: color)),
                Expanded(
                  child: Text(
                    item,
                    style: context.text.bodySmall?.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

class _LinkText extends StatelessWidget {
  const _LinkText({required this.label, required this.trackId, required this.onTap});

  final String label;
  final String trackId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: const BorderRadius.all(AppRadius.sm),
    onTap: () {
      context.trackTap(trackId);
      onTap();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Text(label, style: context.text.labelMedium?.copyWith(color: AppColors.brandSoft)),
    ),
  );
}
