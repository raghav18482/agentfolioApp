import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/logic/research_logic.dart';
import 'package:agentfolio/features/research/presentation/research_style.dart';
import 'package:agentfolio/features/research/presentation/widgets/metric_sheet.dart';
import 'package:flutter/material.dart';

/// One metric in the guide: what it measures, the ideal, its blind spots,
/// and, for scored metrics, the exact bands it is graded on.
class MetricArticle extends StatefulWidget {
  const MetricArticle({required this.metric, required this.highlighted, super.key});

  final GlossaryMetric metric;

  /// Outlined for a moment when a link led here.
  final bool highlighted;

  @override
  State<MetricArticle> createState() => _MetricArticleState();
}

class _MetricArticleState extends State<MetricArticle> {
  bool _bandsOpen = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final m = widget.metric;
    final showBands = m.isScored && m.bands.isNotEmpty;

    return HighlightFrame(
      highlighted: widget.highlighted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.label, style: context.text.titleMedium),
                    if (m.fullName.isNotEmpty) Text(m.fullName, style: context.text.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: AppSpace.sm),
              _ScoredBadge(scored: m.isScored),
            ],
          ),
          if (m.formula.isNotEmpty) ...[const SizedBox(height: AppSpace.md), FormulaBox(m.formula)],
          const SizedBox(height: AppSpace.md),
          Text(m.plain, style: context.text.bodyMedium?.copyWith(height: 1.5)),
          if (m.ideal.isNotEmpty)
            Fact(label: l10n.metricSheetIdeal, body: m.ideal, tone: FactTone.ideal),
          if (m.caveat.isNotEmpty) Fact(label: l10n.metricSheetContext, body: m.caveat),
          if (m.watchOut.isNotEmpty)
            Fact(label: l10n.metricSheetWatchOut, body: m.watchOut, tone: FactTone.warn),
          if (showBands) ...[
            const SizedBox(height: AppSpace.sm),
            Semantics(
              button: true,
              expanded: _bandsOpen,
              child: InkWell(
                borderRadius: const BorderRadius.all(AppRadius.sm),
                onTap: () {
                  context.trackChange('learn_bands_${m.key}', _bandsOpen ? 'closed' : 'open');
                  setState(() => _bandsOpen = !_bandsOpen);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
                  child: Row(
                    children: [
                      AnimatedRotation(
                        turns: _bandsOpen ? 0.25 : 0,
                        duration: AppMotion.of(context, AppMotion.short),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: AppColors.brandSoft,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          l10n.learnHowGraded,
                          style: context.text.labelLarge?.copyWith(color: AppColors.brandSoft),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: AppMotion.of(context, AppMotion.medium),
              curve: AppMotion.enter,
              alignment: Alignment.topCenter,
              child: _bandsOpen
                  ? Column(
                      children: [
                        for (var i = 0; i < m.bands.length; i++) _BandRow(bands: m.bands, index: i),
                      ],
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ],
      ),
    );
  }
}

class _BandRow extends StatelessWidget {
  const _BandRow({required this.bands, required this.index});

  final List<GlossaryBand> bands;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final band = bands[index];
    final color = ResearchStyle.verdict(band.verdict);
    final range = switch (bandRange(bands, index)) {
      AnyValue() => l10n.learnBandAny,
      UpTo(:final max) => l10n.learnBandUpTo(Fmt.number(max)),
      Between(:final from, :final to) => l10n.learnBandBetween(Fmt.number(from), Fmt.number(to)),
      Above(:final from) => l10n.learnBandAbove(Fmt.number(from)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.palette.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 82, child: Text(range, style: context.text.labelMedium?.tabular)),
          Container(
            width: 64,
            padding: const EdgeInsets.symmetric(vertical: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              ResearchStyle.verdictLabel(l10n, band.verdict).toUpperCase(),
              style: context.text.labelSmall?.copyWith(color: color, letterSpacing: 0.3),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          Expanded(child: Text(band.note, style: context.text.bodySmall)),
        ],
      ),
    );
  }
}

class _ScoredBadge extends StatelessWidget {
  const _ScoredBadge({required this.scored});

  final bool scored;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = scored ? AppColors.brandSoft : AppColors.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        (scored ? l10n.learnScored : l10n.learnContextOnly).toUpperCase(),
        style: context.text.labelSmall?.copyWith(color: color, fontSize: 9, letterSpacing: 0.4),
      ),
    );
  }
}

/// A card that glows briefly in the brand colour when [highlighted]: where a
/// link has just brought the reader.
class HighlightFrame extends StatelessWidget {
  const HighlightFrame({required this.highlighted, required this.child, super.key});

  final bool highlighted;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: AppMotion.of(context, AppMotion.long),
    curve: AppMotion.standard,
    padding: const EdgeInsets.all(AppSpace.lg),
    decoration: BoxDecoration(
      color: context.palette.surface,
      borderRadius: AppRadius.card,
      // Only the colour and glow change: a width change would reflow the
      // card's text while the user is reading or tapping it.
      border: Border.all(
        color: highlighted ? AppColors.brandBright : context.palette.border,
        width: 1.5,
      ),
      boxShadow: [
        if (highlighted)
          BoxShadow(color: AppColors.brandBright.withValues(alpha: 0.25), spreadRadius: 3),
      ],
    ),
    child: child,
  );
}
