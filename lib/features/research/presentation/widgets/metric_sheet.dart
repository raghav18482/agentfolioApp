import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/presentation/research_style.dart';
import 'package:flutter/material.dart';

/// What a metric means, from the glossary, and how this stock reads on it.
/// The mobile form of the web's ⓘ popover. [onOpenGuide] leads to the
/// metric's full entry in Learn.
Future<void> showMetricSheet(
  BuildContext context, {
  required String fallbackTitle,
  required GlossaryMetric? metric,
  required VoidCallback onOpenGuide,
  ScoreMetric? reading,
}) => showModalBottomSheet<void>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  builder: (context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.6,
    maxChildSize: 0.92,
    builder: (context, controller) => _MetricSheet(
      controller: controller,
      fallbackTitle: fallbackTitle,
      metric: metric,
      reading: reading,
      onOpenGuide: () {
        Navigator.of(context).pop();
        onOpenGuide();
      },
    ),
  ),
);

class _MetricSheet extends StatelessWidget {
  const _MetricSheet({
    required this.controller,
    required this.fallbackTitle,
    required this.metric,
    required this.reading,
    required this.onOpenGuide,
  });

  final ScrollController controller;
  final String fallbackTitle;
  final GlossaryMetric? metric;
  final ScoreMetric? reading;
  final VoidCallback onOpenGuide;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final m = metric;
    final r = reading;
    final showReading =
        r != null &&
        r.note.isNotEmpty &&
        r.verdict != Verdict.unknown &&
        r.verdict != Verdict.excluded;

    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.xl),
      children: [
        Text(
          m?.fullName.isNotEmpty ?? false ? m!.fullName : fallbackTitle,
          style: context.text.titleLarge,
        ),
        if (m == null) ...[
          const SizedBox(height: AppSpace.md),
          Text(l10n.metricSheetNoExplanation, style: context.text.bodyMedium),
        ] else ...[
          if (m.formula.isNotEmpty) ...[const SizedBox(height: AppSpace.md), FormulaBox(m.formula)],
          const SizedBox(height: AppSpace.md),
          Text(m.plain, style: context.text.bodyMedium?.copyWith(height: 1.5)),
          if (showReading) ...[const SizedBox(height: AppSpace.lg), _Reading(reading: r)],
          if (m.ideal.isNotEmpty)
            Fact(label: l10n.metricSheetIdeal, body: m.ideal, tone: FactTone.ideal),
          if (m.caveat.isNotEmpty) Fact(label: l10n.metricSheetContext, body: m.caveat),
          if (m.watchOut.isNotEmpty)
            Fact(label: l10n.metricSheetWatchOut, body: m.watchOut, tone: FactTone.warn),
          const SizedBox(height: AppSpace.xl),
          AppButton(
            trackId: 'metric_sheet_open_guide',
            label: l10n.metricSheetReadMore,
            icon: Icons.menu_book_rounded,
            variant: AppButtonVariant.secondary,
            size: AppButtonSize.medium,
            onPressed: onOpenGuide,
          ),
        ],
      ],
    );
  }
}

/// "This stock: 24.1x — Fairly valued", in the verdict's colour with a dot.
class _Reading extends StatelessWidget {
  const _Reading({required this.reading});

  final ScoreMetric reading;

  @override
  Widget build(BuildContext context) {
    final color = ResearchStyle.verdict(reading.verdict);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpace.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: AppRadius.card,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 5), child: VerdictDot(reading.verdict)),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            child: Text(
              l10n.metricSheetThisStock(reading.display, reading.note),
              style: context.text.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// The formula, in a quiet monospace box.
class FormulaBox extends StatelessWidget {
  const FormulaBox(this.formula, {super.key});

  final String formula;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: AppSpace.md, vertical: AppSpace.sm),
    decoration: const BoxDecoration(
      color: AppColors.surfaceRaised,
      borderRadius: BorderRadius.all(AppRadius.sm),
    ),
    child: Text(
      formula,
      style: context.text.bodySmall?.copyWith(
        fontFamily: 'monospace',
        fontFamilyFallback: const ['Menlo', 'Courier'],
        color: AppColors.brandSoft,
      ),
    ),
  );
}

enum FactTone { plain, ideal, warn }

/// A labelled fact with a coloured rule: Ideal, Context, Watch out.
class Fact extends StatelessWidget {
  const Fact({required this.label, required this.body, super.key, this.tone = FactTone.plain});

  final String label;
  final String body;
  final FactTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      FactTone.ideal => AppColors.brandSoft,
      FactTone.warn => AppColors.orange,
      FactTone.plain => AppColors.textMuted,
    };
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(AppSpace.md, AppSpace.sm, AppSpace.md, AppSpace.sm),
        decoration: BoxDecoration(
          color: context.palette.surfaceRaised.withValues(alpha: 0.6),
          borderRadius: const BorderRadius.horizontal(right: AppRadius.sm),
          border: Border(left: BorderSide(color: color, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: context.text.labelSmall?.copyWith(color: color)),
            const SizedBox(height: 2),
            Text(
              body,
              style: context.text.bodySmall?.copyWith(color: AppColors.textPrimary, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

/// A metric's verdict as a dot, with its name for screen readers.
class VerdictDot extends StatelessWidget {
  const VerdictDot(this.verdict, {super.key, this.size = 8});

  final Verdict verdict;
  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
    label: ResearchStyle.verdictLabel(AppLocalizations.of(context), verdict),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: ResearchStyle.verdict(verdict)),
    ),
  );
}
