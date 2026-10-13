import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Colours and words for moods and tones. Never colour alone: every mood
/// also carries a word and every tone a shape.
abstract final class MoodStyle {
  static Color mood(Mood m) => switch (m) {
    Mood.bullish => AppColors.gain,
    Mood.bearish => AppColors.loss,
    Mood.neutral => AppColors.warning,
  };

  static String moodLabel(AppLocalizations l10n, Mood m) => switch (m) {
    Mood.bullish => l10n.moodBullish,
    Mood.bearish => l10n.moodBearish,
    Mood.neutral => l10n.moodNeutral,
  };

  static Color tone(ArticleTone t) => switch (t) {
    ArticleTone.positive => AppColors.gain,
    ArticleTone.negative => AppColors.loss,
    ArticleTone.neutral => AppColors.textMuted,
  };

  static IconData toneIcon(ArticleTone t) => switch (t) {
    ArticleTone.positive => Icons.trending_up_rounded,
    ArticleTone.negative => Icons.trending_down_rounded,
    ArticleTone.neutral => Icons.trending_flat_rounded,
  };

  static String toneLabel(AppLocalizations l10n, ArticleTone t) => switch (t) {
    ArticleTone.positive => l10n.tonePositive,
    ArticleTone.negative => l10n.toneNegative,
    ArticleTone.neutral => l10n.toneNeutral,
  };
}

/// Bullish, neutral and bearish shares as one bar, with their percentages.
class MoodBar extends StatelessWidget {
  const MoodBar({required this.summary, super.key});

  final SentimentSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = summary.total;
    if (total == 0) return const SizedBox.shrink();
    String pct(int n) => '${(n / total * 100).round()}%';
    final parts = [
      (summary.bullish, AppColors.gain, l10n.moodBullish),
      (summary.neutral, AppColors.warning, l10n.moodNeutral),
      (summary.bearish, AppColors.loss, l10n.moodBearish),
    ];
    return Semantics(
      label: l10n.moodBarSemantics(
        pct(summary.bullish),
        pct(summary.neutral),
        pct(summary.bearish),
      ),
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  for (final (n, color, _) in parts)
                    if (n > 0)
                      Expanded(
                        flex: n,
                        child: Container(color: color),
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpace.sm),
          Row(
            children: [
              for (var i = 0; i < parts.length; i++)
                Expanded(
                  child: Text(
                    '${parts[i].$3} ${pct(parts[i].$1)}',
                    // Bullish under the left end, bearish under the right.
                    textAlign: const [TextAlign.start, TextAlign.center, TextAlign.end][i],
                    style: context.text.labelMedium?.copyWith(color: parts[i].$2),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small pill naming a mood: on sector headers once sentiment is read.
class MoodPill extends StatelessWidget {
  const MoodPill(this.mood, {super.key});

  final Mood mood;

  @override
  Widget build(BuildContext context) => StatusChip(
    MoodStyle.moodLabel(AppLocalizations.of(context), mood).toUpperCase(),
    color: MoodStyle.mood(mood),
  );
}

/// One headline: title, source and age, a line of summary, and its tone
/// once sentiment is read. Opens the article in the in-app browser.
class ArticleTile extends StatelessWidget {
  const ArticleTile({required this.article, required this.trackId, super.key});

  final NewsArticle article;
  final String trackId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final a = article;
    final age = a.publishedAt == null ? a.rawDate : Times.relative(a.publishedAt!);
    final meta = [if (a.source.isNotEmpty) a.source, if (age.isNotEmpty) age].join(' · ');
    final tone = a.sentiment;

    return InkWell(
      borderRadius: const BorderRadius.all(AppRadius.sm),
      onTap: a.link == null
          ? null
          : () {
              context.trackTap(trackId);
              unawaited(context.read<LinkOpener>().open(a.link!, id: 'news_article'));
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.titleSmall?.copyWith(height: 1.35),
                  ),
                  if (a.description.isNotEmpty && a.description != a.title) ...[
                    const SizedBox(height: 4),
                    Text(
                      a.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (tone != null) ...[
                        Icon(
                          MoodStyle.toneIcon(tone.tone),
                          size: 15,
                          color: MoodStyle.tone(tone.tone),
                          semanticLabel: MoodStyle.toneLabel(l10n, tone.tone),
                        ),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          meta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.labelSmall?.copyWith(letterSpacing: 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (a.link != null) ...[
              const SizedBox(width: AppSpace.sm),
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A sector's headlines under a header with what the user has in it.
/// Collapses to the header, so eight sectors still scan in one screen.
class SectorNewsGroup extends StatefulWidget {
  const SectorNewsGroup({required this.sector, super.key, this.initiallyOpen = false});

  final SectorNews sector;
  final bool initiallyOpen;

  @override
  State<SectorNewsGroup> createState() => _SectorNewsGroupState();
}

class _SectorNewsGroupState extends State<SectorNewsGroup> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = widget.sector;
    final duration = AppMotion.of(context, AppMotion.medium);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            expanded: _open,
            child: InkWell(
              borderRadius: AppRadius.card,
              onTap: s.articles.isEmpty
                  ? null
                  : () {
                      context.trackChange('news_sector', _open ? 'closed' : 'open');
                      setState(() => _open = !_open);
                    },
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.name, style: context.text.titleMedium),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Flexible(
                                child: MoneyText(
                                  s.invested,
                                  format: MoneyStyle.compact,
                                  style: context.text.labelMedium,
                                ),
                              ),
                              // Both shrink, so a mood pill beside them never
                              // pushes the line off a small phone.
                              Flexible(
                                child: Text(
                                  ' · ${l10n.newsArticleCount(s.articles.length)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.text.labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (s.sentiment != null) ...[
                      MoodPill(s.sentiment!.mood),
                      const SizedBox(width: AppSpace.sm),
                    ],
                    if (s.articles.isNotEmpty)
                      AnimatedRotation(
                        turns: _open ? 0.5 : 0,
                        duration: duration,
                        child: const Icon(Icons.expand_more_rounded, color: AppColors.textMuted),
                      ),
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
                    padding: const EdgeInsets.fromLTRB(AppSpace.lg, 0, AppSpace.lg, AppSpace.sm),
                    child: Column(
                      children: [
                        for (var i = 0; i < s.articles.length; i++) ...[
                          Divider(height: 1, color: context.palette.border),
                          ArticleTile(article: s.articles[i], trackId: 'news_article_open'),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
