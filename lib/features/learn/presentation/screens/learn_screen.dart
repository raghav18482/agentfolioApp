import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/async_view.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/learn/presentation/view_models/learn_view_model.dart';
import 'package:agentfolio/features/learn/presentation/widgets/metric_article.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/presentation/research_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// The metrics guide, drawn from the glossary the Python scorer grades
/// against, so every threshold shown is the one actually used. None of it is
/// written by AI.
///
/// [focus] is a metric key (`pe_ratio`) or [Routes.learnScoringAnchor]: the
/// screen scrolls there once loaded and outlines it for a moment, as when a
/// metric sheet's "Read more" leads here.
class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key, this.focus});

  final String? focus;

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final _anchors = <String, GlobalKey>{};
  String? _highlighted;
  bool _focused = false;
  Timer? _fade;

  GlobalKey _anchor(String id) => _anchors.putIfAbsent(id, () => GlobalKey(debugLabel: id));

  @override
  void initState() {
    super.initState();
    unawaited(context.read<LearnViewModel>().load());
  }

  @override
  void dispose() {
    _fade?.cancel();
    super.dispose();
  }

  void _scrollTo(String id, {bool userInitiated = true}) {
    final target = _anchors[id]?.currentContext;
    if (target == null) return;
    if (userInitiated) HapticFeedback.selectionClick().ignore();
    Scrollable.ensureVisible(
      target,
      alignment: 0.08,
      duration: AppMotion.of(context, const Duration(milliseconds: 450)),
      curve: AppMotion.standard,
    );
    setState(() => _highlighted = id);
    _fade?.cancel();
    _fade = Timer(const Duration(milliseconds: 2400), () {
      if (mounted) setState(() => _highlighted = null);
    });
  }

  /// Scrolls to [LearnScreen.focus] once, on the first frame with content.
  void _maybeFocus(Glossary _) {
    final focus = widget.focus;
    if (_focused || focus == null) return;
    _focused = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _scrollTo(focus, userInitiated: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<LearnViewModel>();
    final state = context.select<LearnViewModel, ViewState<Glossary>>((vm) => vm.glossary.state);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.learnTitle)),
      body: AsyncView(
        state: state,
        retryTrackId: 'learn_retry',
        onRetry: () => unawaited(vm.glossary.load(force: true)),
        skeleton: const _Skeleton(),
        builder: (context, glossary) {
          _maybeFocus(glossary);
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSpace.page,
              AppSpace.sm,
              AppSpace.page,
              AppSpace.xxl + MediaQuery.paddingOf(context).bottom,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(l10n.learnHeadline, style: context.text.headlineSmall),
                    const SizedBox(height: AppSpace.sm),
                    Text(
                      l10n.learnSubtitle,
                      style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                    // The index first: returning readers come for one metric.
                    const SizedBox(height: AppSpace.xl),
                    _JumpTo(glossary: glossary, onJump: _scrollTo),
                    const SizedBox(height: AppSpace.xl),
                    _Intro(items: glossary.intro),
                    for (final pillar in glossary.pillars) ...[
                      const SizedBox(height: AppSpace.xxl),
                      _PillarHeader(pillar: pillar),
                      for (final metric in glossary.metricsFor(pillar.key)) ...[
                        const SizedBox(height: AppSpace.md),
                        MetricArticle(
                          key: _anchor(metric.key),
                          metric: metric,
                          highlighted: _highlighted == metric.key,
                        ),
                      ],
                    ],
                    const SizedBox(height: AppSpace.xxl),
                    _Scoring(
                      key: _anchor(Routes.learnScoringAnchor),
                      scoring: glossary.scoring,
                      highlighted: _highlighted == Routes.learnScoringAnchor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.items});

  final List<GlossaryIntro> items;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(AppLocalizations.of(context).learnIntroTitle, style: context.text.titleLarge),
      const SizedBox(height: AppSpace.md),
      for (var i = 0; i < items.length; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpace.sm),
          child: AppCard(
            padding: const EdgeInsets.all(AppSpace.md + 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.brandBright.withValues(alpha: 0.12),
                    border: Border.all(color: AppColors.brandBright.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    '${i + 1}',
                    style: context.text.labelMedium?.copyWith(color: AppColors.brandSoft),
                  ),
                ),
                const SizedBox(width: AppSpace.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[i].title, style: context.text.titleSmall),
                      const SizedBox(height: 2),
                      Text(items[i].body, style: context.text.bodySmall?.copyWith(height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

/// Every metric as a chip under its pillar: the guide's table of contents.
class _JumpTo extends StatelessWidget {
  const _JumpTo({required this.glossary, required this.onJump});

  final Glossary glossary;
  final void Function(String id) onJump;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.learnJumpTo, style: context.text.titleSmall),
          for (final pillar in glossary.pillars) ...[
            const SizedBox(height: AppSpace.md),
            Text(pillar.label.toUpperCase(), style: context.text.labelSmall),
            const SizedBox(height: AppSpace.sm),
            Wrap(
              spacing: AppSpace.sm,
              runSpacing: AppSpace.sm,
              children: [
                for (final m in glossary.metricsFor(pillar.key))
                  _Chip(
                    label: m.label,
                    onTap: () {
                      context.trackTap('learn_jump_${m.key}');
                      onJump(m.key);
                    },
                  ),
              ],
            ),
          ],
          const SizedBox(height: AppSpace.md),
          Align(
            alignment: Alignment.centerLeft,
            child: _Chip(
              label: l10n.learnScoringTitle,
              icon: Icons.calculate_outlined,
              onTap: () {
                context.trackTap('learn_jump_scoring');
                onJump(Routes.learnScoringAnchor);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.onTap, this.icon});

  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: context.palette.surfaceRaised,
    shape: StadiumBorder(side: BorderSide(color: context.palette.border)),
    child: InkWell(
      customBorder: const StadiumBorder(),
      onTap: onTap,
      child: Padding(
        // Tall enough for a thumb, even with short labels.
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: AppColors.brandSoft),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelMedium?.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PillarHeader extends StatelessWidget {
  const _PillarHeader({required this.pillar});

  final GlossaryPillar pillar;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(pillar.label, style: context.text.headlineSmall),
      if (pillar.tagline.isNotEmpty)
        Text(pillar.tagline, style: context.text.labelLarge?.copyWith(color: AppColors.brandSoft)),
      if (pillar.body.isNotEmpty) ...[
        const SizedBox(height: AppSpace.sm),
        Text(
          pillar.body,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.5),
        ),
      ],
    ],
  );
}

class _Scoring extends StatelessWidget {
  const _Scoring({required this.scoring, required this.highlighted, super.key});

  final ScoringGuide scoring;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.learnScoringTitle, style: context.text.headlineSmall),
        const SizedBox(height: AppSpace.md),
        HighlightFrame(
          highlighted: highlighted,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < scoring.howItWorks.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpace.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 22, child: Text('${i + 1}.', style: context.text.bodyMedium)),
                      Expanded(
                        child: Text(
                          scoring.howItWorks[i],
                          style: context.text.bodyMedium?.copyWith(height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpace.md),
              Text(l10n.learnGradeBands.toUpperCase(), style: context.text.labelSmall),
              const SizedBox(height: AppSpace.sm),
              Wrap(
                spacing: AppSpace.sm,
                runSpacing: AppSpace.sm,
                children: [
                  for (final g in scoring.grades)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: context.palette.surfaceRaised,
                        borderRadius: const BorderRadius.all(AppRadius.sm),
                        border: Border.all(color: context.palette.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            g.grade,
                            style: context.text.titleMedium?.copyWith(
                              color: ResearchStyle.grade(g.grade),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(g.label, style: context.text.labelMedium),
                          const SizedBox(width: 6),
                          Text(
                            l10n.learnGradeMin(g.min.round()),
                            style: context.text.labelSmall?.copyWith(letterSpacing: 0),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text(l10n.learnLimits.toUpperCase(), style: context.text.labelSmall),
              const SizedBox(height: AppSpace.xs),
              Text(scoring.limits, style: context.text.bodyMedium?.copyWith(height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(AppSpace.page),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonBox(width: 260, height: 26),
        SizedBox(height: AppSpace.md),
        SkeletonBox(width: double.infinity, height: 56),
        SizedBox(height: AppSpace.xl),
        SkeletonBox(width: double.infinity, height: 90),
        SizedBox(height: AppSpace.sm),
        SkeletonBox(width: double.infinity, height: 90),
        SizedBox(height: AppSpace.xl),
        SkeletonBox(width: double.infinity, height: 220),
      ],
    ),
  );
}
