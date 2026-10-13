import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/app_choice_chips.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:agentfolio/core/presentation/widgets/error_view.dart';
import 'package:agentfolio/core/presentation/widgets/fade_slide_in.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:agentfolio/features/markets/presentation/view_models/markets_view_model.dart';
import 'package:agentfolio/features/markets/presentation/widgets/news_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// News for the sectors the user holds, with an on-demand sentiment read,
/// and a search over all news.
class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late final _controller = TextEditingController(text: context.read<MarketsViewModel>().query);
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Suggestions show while the field is focused.
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _search(String text) {
    // The query itself is never reported: it is user-entered text.
    context.trackTap('news_search_submit');
    _focus.unfocus();
    context.read<MarketsViewModel>().submitSearch(text);
  }

  void _clear() {
    _controller.clear();
    context.read<MarketsViewModel>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<MarketsViewModel>();
    final showSuggestions = _focus.hasFocus && _controller.text.trim().isEmpty;

    return RefreshIndicator(
      color: AppColors.brandSoft,
      backgroundColor: AppColors.surfaceRaised,
      onRefresh: vm.refresh,
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.md, AppSpace.page, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _controller,
                      focusNode: _focus,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: l10n.newsSearchHint,
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(Icons.search_rounded, size: 20),
                        suffixIcon: _controller.text.isEmpty && !vm.searching
                            ? null
                            : IconButton(
                                tooltip: l10n.newsSearchClear,
                                icon: const Icon(Icons.close_rounded, size: 18),
                                onPressed: _clear,
                              ),
                      ),
                    ),
                  ),
                  if (showSuggestions) ...[
                    const SizedBox(height: AppSpace.md),
                    Wrap(
                      spacing: AppSpace.sm,
                      runSpacing: AppSpace.sm,
                      children: [
                        for (final s in vm.suggestions)
                          ActionChip(
                            label: Text(s),
                            onPressed: () {
                              _controller.text = s;
                              _search(s);
                            },
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: AppSpace.sm),
                  AppChoiceChips<NewsPeriod>(
                    trackId: 'news_period',
                    selected: vm.period,
                    onChanged: vm.selectPeriod,
                    options: [
                      AppSegment(value: NewsPeriod.day, label: l10n.newsPeriodDay, id: '1d'),
                      AppSegment(value: NewsPeriod.week, label: l10n.newsPeriodWeek, id: '7d'),
                      AppSegment(value: NewsPeriod.month, label: l10n.newsPeriodMonth, id: '1m'),
                      AppSegment(
                        value: NewsPeriod.quarter,
                        label: l10n.newsPeriodQuarter,
                        id: '3m',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpace.md),
                ],
              ),
            ),
          ),
          if (vm.searching) ..._results(context, vm) else ..._portfolio(context, vm),
          const SliverPadding(padding: EdgeInsets.only(bottom: AppSpace.xxl)),
        ],
      ),
    );
  }

  List<Widget> _portfolio(BuildContext context, MarketsViewModel vm) {
    final l10n = AppLocalizations.of(context);
    return switch (vm.news.state) {
      ViewIdle() || ViewLoading() => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.md),
            child: Text(
              l10n.newsGathering,
              style: context.text.labelMedium?.copyWith(color: AppColors.brandSoft),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: _FeedSkeleton()),
      ],
      ViewError(:final failure) => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            failure: failure,
            retryTrackId: 'news_retry',
            onRetry: () => unawaited(vm.news.load(force: true)),
          ),
        ),
      ],
      ViewData(:final data) when data.sectors.isEmpty => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyState(
            icon: Icons.newspaper_rounded,
            title: l10n.newsNoHoldingsTitle,
            message: l10n.newsNoHoldingsBody,
          ),
        ),
      ],
      // Every sector empty at once is a failed news source far more often
      // than a quiet market (the server reports a failed search as "no
      // articles"), so it is said plainly, with Retry.
      ViewData(:final data) when data.articleCount == 0 => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyState(
            icon: Icons.cloud_off_rounded,
            iconColor: AppColors.warning,
            title: l10n.newsNoneBackTitle,
            message: l10n.newsNoneBackBody,
            action: AppButton(
              trackId: 'news_empty_retry',
              label: l10n.commonRetry,
              icon: Icons.refresh_rounded,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              onPressed: () => unawaited(vm.news.load(force: true)),
            ),
          ),
        ),
      ],
      ViewData() => [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.page),
          sliver: SliverList.list(
            children: [
              const _SentimentPulse(),
              const SizedBox(height: AppSpace.lg),
              for (var i = 0; i < vm.newsSectors.length; i++) ...[
                FadeSlideIn(
                  delay: Duration(milliseconds: 50 * i),
                  child: SectorNewsGroup(
                    key: ValueKey('${vm.period.wire}/${vm.newsSectors[i].name}'),
                    sector: vm.newsSectors[i],
                    initiallyOpen: i == 0,
                  ),
                ),
                const SizedBox(height: AppSpace.md),
              ],
            ],
          ),
        ),
      ],
    };
  }

  List<Widget> _results(BuildContext context, MarketsViewModel vm) {
    final l10n = AppLocalizations.of(context);
    return switch (vm.search.state) {
      ViewIdle() || ViewLoading() => [const SliverToBoxAdapter(child: _FeedSkeleton())],
      ViewError(:final failure) => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            failure: failure,
            retryTrackId: 'news_search_retry',
            onRetry: () => unawaited(vm.search.load(force: true)),
          ),
        ),
      ],
      ViewData(:final data) when data.isEmpty => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyState(
            icon: Icons.search_off_rounded,
            title: l10n.newsNoResults(vm.query),
            message: l10n.newsNoResultsBody,
          ),
        ),
      ],
      ViewData(:final data, :final refreshing) => [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.page),
          sliver: SliverList.list(
            children: [
              Text(l10n.newsResultsFor(vm.query), style: context.text.labelMedium),
              if (refreshing) const LinearProgressIndicator(minHeight: 2),
              for (final a in data) ...[
                ArticleTile(article: a, trackId: 'news_result_open'),
                Divider(height: 1, color: context.palette.border),
              ],
            ],
          ),
        ),
      ],
    };
  }
}

/// The mood of the news across the user's sectors, read by FinBERT on
/// request: it is heavy on the server, so it is never run unasked.
class _SentimentPulse extends StatelessWidget {
  const _SentimentPulse();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<MarketsViewModel>();
    final count = vm.news.data?.articleCount ?? 0;
    final state = vm.sentiment.state;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.monitor_heart_outlined, size: 20, color: AppColors.brandSoft),
              const SizedBox(width: AppSpace.sm),
              Expanded(child: Text(l10n.sentimentTitle, style: context.text.titleMedium)),
            ],
          ),
          const SizedBox(height: AppSpace.md),
          switch (state) {
            ViewIdle() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.sentimentPrompt(count), style: context.text.bodySmall),
                const SizedBox(height: AppSpace.md),
                AppButton(
                  trackId: 'news_sentiment_run',
                  label: l10n.sentimentRun,
                  icon: Icons.psychology_alt_outlined,
                  size: AppButtonSize.medium,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => unawaited(vm.readSentiment()),
                ),
              ],
            ),
            ViewLoading() => Shimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.sentimentReading(count),
                    style: context.text.labelMedium?.copyWith(color: AppColors.brandSoft),
                  ),
                  const SizedBox(height: AppSpace.md),
                  const SkeletonBox(width: double.infinity, height: 10),
                ],
              ),
            ),
            ViewError(:final failure) => SectionFailure(
              // A 503 means the server has no sentiment model loaded; its
              // message is for developers, so say it plainly instead.
              failure: failure is BrokerFailure && failure.statusCode == 503
                  ? UnavailableFailure(l10n.sentimentUnavailable)
                  : failure,
              retryTrackId: 'news_sentiment_retry',
              onRetry: () => unawaited(vm.readSentiment()),
            ),
            ViewData(:final data) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      MoodStyle.moodLabel(l10n, data.overall.mood),
                      style: context.text.headlineSmall?.copyWith(
                        color: MoodStyle.mood(data.overall.mood),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: AppSpace.sm),
                    Expanded(
                      child: Text(
                        l10n.sentimentAnalysed(data.overall.total),
                        style: context.text.labelMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.md),
                MoodBar(summary: data.overall),
              ],
            ),
          },
          const SizedBox(height: AppSpace.md),
          Text(
            l10n.sentimentFineprint,
            style: context.text.labelSmall?.copyWith(
              letterSpacing: 0,
              color: context.palette.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedSkeleton extends StatelessWidget {
  const _FeedSkeleton();

  @override
  Widget build(BuildContext context) => const Shimmer(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpace.page),
      child: Column(
        children: [
          SkeletonBox(width: double.infinity, height: 120),
          SizedBox(height: AppSpace.lg),
          SkeletonBox(width: double.infinity, height: 260),
          SizedBox(height: AppSpace.md),
          SkeletonBox(width: double.infinity, height: 72),
          SizedBox(height: AppSpace.md),
          SkeletonBox(width: double.infinity, height: 72),
        ],
      ),
    ),
  );
}
