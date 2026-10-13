import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:agentfolio/features/markets/domain/logic/markets_logic.dart';
import 'package:agentfolio/features/markets/presentation/view_models/markets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The market's breadth today, the indices moving most, and the user's
/// sectors against their NSE indices.
class SectorsView extends StatelessWidget {
  const SectorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<MarketsViewModel>();

    return RefreshIndicator(
      color: AppColors.brandSoft,
      backgroundColor: AppColors.surfaceRaised,
      onRefresh: vm.refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.lg, AppSpace.page, AppSpace.xxl),
        children: [
          SectionState(
            state: vm.breadth.state,
            retryTrackId: 'breadth_retry',
            onRetry: () => unawaited(vm.breadth.load(force: true)),
            skeleton: const Column(
              children: [
                SkeletonBox(width: double.infinity, height: 78),
                SizedBox(height: AppSpace.lg),
                SkeletonBox(width: double.infinity, height: 280),
              ],
            ),
            builder: (context, breadth) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BreadthStrip(breadth: breadth),
                if (breadth.indices.isNotEmpty) ...[
                  const SizedBox(height: AppSpace.lg),
                  _IndexMovers(indices: breadth.indices),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpace.xl),
          Text(l10n.sectorsYours, style: context.text.titleLarge),
          const SizedBox(height: AppSpace.md),
          SectionState(
            state: vm.sectors.state,
            retryTrackId: 'sectors_retry',
            onRetry: () => unawaited(vm.sectors.load(force: true)),
            skeleton: const Column(
              children: [
                SkeletonBox(width: double.infinity, height: 96),
                SizedBox(height: AppSpace.md),
                SkeletonBox(width: double.infinity, height: 96),
              ],
            ),
            builder: (context, sectors) => sectors.isEmpty
                ? EmptyState(
                    icon: Icons.pie_chart_outline_rounded,
                    title: l10n.sectorsEmptyTitle,
                    message: l10n.sectorsEmptyBody,
                  )
                : Column(
                    children: [
                      for (var i = 0; i < sectors.length; i++) ...[
                        _SectorCard(sector: sectors[i], initiallyOpen: i == 0),
                        const SizedBox(height: AppSpace.md),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

/// India VIX, indices up versus down, and 52-week highs versus lows.
class _BreadthStrip extends StatelessWidget {
  const _BreadthStrip({required this.breadth});

  final MarketBreadth breadth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final b = breadth;
    final tiles = <Widget>[
      if (b.vix != null)
        _Stat(
          label: l10n.breadthVix,
          value: b.vix!.toStringAsFixed(2),
          // Today's live move when NSE's market watch has it, so the tile
          // agrees with the rest of the screen; else the daily history's.
          // Volatility rising means fear rising: amber, not green.
          caption: b.vixChangePercent != null
              ? Fmt.signedPct(b.vixChangePercent)
              : b.vixChange == null
              ? null
              : '${b.vixChange! >= 0 ? '+' : ''}${b.vixChange!.toStringAsFixed(2)}',
          captionColor: (b.vixChangePercent ?? b.vixChange ?? 0) > 0
              ? AppColors.warning
              : AppColors.gain,
        ),
      if (b.advances != null && b.declines != null)
        _Stat(
          label: l10n.breadthIndices,
          value: '${b.advances} / ${b.declines}',
          caption: l10n.breadthUpDown,
          captionColor: b.advances! >= b.declines! ? AppColors.gain : AppColors.loss,
        ),
      if (b.week52Highs != null && b.week52Lows != null)
        _Stat(
          label: l10n.breadth52w,
          value: '${b.week52Highs} / ${b.week52Lows}',
          caption: l10n.breadthHighsLows,
          captionColor: b.week52Highs! >= b.week52Lows! ? AppColors.gain : AppColors.loss,
        ),
    ];
    if (tiles.isEmpty) return const SizedBox.shrink();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < tiles.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpace.sm),
            Expanded(child: tiles[i]),
          ],
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, this.caption, this.captionColor});

  final String label;
  final String value;
  final String? caption;
  final Color? captionColor;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.all(AppSpace.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.text.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(value, style: context.text.titleLarge?.tabular),
        ),
        if (caption != null)
          Text(
            caption!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.labelSmall?.copyWith(color: captionColor, letterSpacing: 0),
          ),
      ],
    ),
  );
}

/// The indices up and down most today as diverging bars, with the full list
/// a tap away. NSE publishes over a hundred indices; a phone shows ten.
class _IndexMovers extends StatelessWidget {
  const _IndexMovers({required this.indices});

  final List<IndexMove> indices;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final moves = topMoves(indices);
    final shown = [...moves.up, ...moves.down.reversed];
    final scale = shown.fold<double>(
      0.01,
      (m, i) => i.changePercent.abs() > m ? i.changePercent.abs() : m,
    );

    return SectionCard(
      title: l10n.moversTitle,
      subtitle: l10n.moversSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final m in shown) _MoveBar(move: m, scale: scale),
          const SizedBox(height: AppSpace.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: AppButton(
              trackId: 'index_movers_all',
              label: l10n.moversAll(indices.length),
              variant: AppButtonVariant.ghost,
              size: AppButtonSize.medium,
              onPressed: () => unawaited(_showAll(context, indices)),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _showAll(BuildContext context, List<IndexMove> indices) {
    final sorted = [...indices]..sort((a, b) => b.changePercent.compareTo(a.changePercent));
    final scale = sorted.fold<double>(
      0.01,
      (m, i) => i.changePercent.abs() > m ? i.changePercent.abs() : m,
    );
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.xl),
          children: [
            Text(AppLocalizations.of(context).moversAllTitle, style: context.text.titleLarge),
            const SizedBox(height: AppSpace.md),
            for (final m in sorted) _MoveBar(move: m, scale: scale),
          ],
        ),
      ),
    );
  }
}

/// An index name with a bar from the centre: right and green for a rise,
/// left and red for a fall, and the percentage.
class _MoveBar extends StatelessWidget {
  const _MoveBar({required this.move, required this.scale});

  final IndexMove move;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final up = move.changePercent >= 0;
    final color = up ? AppColors.gain : AppColors.loss;
    final fraction = (move.changePercent.abs() / scale).clamp(0.04, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              indexDisplayName(move.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.bodySmall?.copyWith(color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            flex: 4,
            child: LayoutBuilder(
              builder: (context, c) {
                final half = c.maxWidth / 2;
                return SizedBox(
                  height: 12,
                  child: Stack(
                    children: [
                      Positioned(
                        left: half - 0.5,
                        top: 0,
                        bottom: 0,
                        child: Container(width: 1, color: context.palette.border),
                      ),
                      Positioned(
                        left: up ? half : half - half * fraction,
                        width: half * fraction,
                        top: 2,
                        bottom: 2,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: AppMotion.of(context, const Duration(milliseconds: 600)),
                          curve: Curves.easeOutCubic,
                          builder: (context, t, _) => Align(
                            alignment: up ? Alignment.centerLeft : Alignment.centerRight,
                            child: FractionallySizedBox(
                              widthFactor: t,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          SizedBox(
            width: 58,
            child: Text(
              Fmt.signedPct(move.changePercent),
              textAlign: TextAlign.end,
              style: context.text.labelMedium?.tabular.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// One of the user's sectors: its share of the portfolio, its index's
/// returns, what drives it, and the holdings in it (tap one to open it).
class _SectorCard extends StatefulWidget {
  const _SectorCard({required this.sector, required this.initiallyOpen});

  final SectorExposure sector;
  final bool initiallyOpen;

  @override
  State<_SectorCard> createState() => _SectorCardState();
}

class _SectorCardState extends State<_SectorCard> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = widget.sector;
    final duration = AppMotion.of(context, AppMotion.medium);
    final month = s.indexReturns?.month;

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
              onTap: () {
                context.trackChange('sector_card', _open ? 'closed' : 'open');
                setState(() => _open = !_open);
              },
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(s.name, style: context.text.titleMedium)),
                        if (month != null) ...[
                          Text('1M ', style: context.text.labelSmall),
                          PnlPercent(month, style: context.text.labelMedium),
                          const SizedBox(width: AppSpace.sm),
                        ],
                        AnimatedRotation(
                          turns: _open ? 0.5 : 0,
                          duration: duration,
                          child: const Icon(Icons.expand_more_rounded, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpace.sm),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: (s.weight / 100).clamp(0, 1),
                              minHeight: 6,
                              color: AppColors.brandSoft,
                              backgroundColor: context.palette.surfaceRaised,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpace.md),
                        Text(Fmt.percent(s.weight), style: context.text.labelLarge?.tabular),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${l10n.sectorHoldings(s.holdingsCount)} · ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.labelMedium,
                          ),
                        ),
                        Flexible(
                          child: MoneyText(
                            s.invested,
                            format: MoneyStyle.compact,
                            style: context.text.labelMedium,
                          ),
                        ),
                      ],
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
                    padding: const EdgeInsets.fromLTRB(AppSpace.lg, 0, AppSpace.lg, AppSpace.lg),
                    child: _SectorDetail(sector: s),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SectorDetail extends StatelessWidget {
  const _SectorDetail({required this.sector});

  final SectorExposure sector;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = sector;
    final r = s.indexReturns;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 1, color: context.palette.border),
        const SizedBox(height: AppSpace.md),
        if (s.indexName != null) ...[
          Text(l10n.sectorIndex(s.indexName!), style: context.text.labelMedium),
          const SizedBox(height: AppSpace.sm),
        ],
        if (r != null)
          Wrap(
            spacing: AppSpace.sm,
            runSpacing: AppSpace.sm,
            children: [
              for (final (label, value) in [
                ('1W', r.week),
                ('1M', r.month),
                ('3M', r.quarter),
                ('6M', r.halfYear),
                ('1Y', r.year),
              ])
                if (value != null)
                  StatusChip('$label ${Fmt.signedPct(value)}', color: context.palette.pnl(value)),
            ],
          ),
        if (s.driver.isNotEmpty) ...[
          const SizedBox(height: AppSpace.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline_rounded, size: 16, color: AppColors.warning),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                child: Text(
                  l10n.sectorDriver(s.driver),
                  style: context.text.bodySmall?.copyWith(height: 1.45),
                ),
              ),
            ],
          ),
        ],
        if (s.holdings.isNotEmpty) ...[
          const SizedBox(height: AppSpace.md),
          Text(l10n.sectorYourHoldings.toUpperCase(), style: context.text.labelSmall),
          for (final h in s.holdings)
            InkWell(
              borderRadius: const BorderRadius.all(AppRadius.sm),
              onTap: () {
                context.trackTap('sector_holding_open');
                unawaited(context.push(Routes.stockOf(h.symbol)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
                child: Row(
                  children: [
                    Expanded(child: Text(Fmt.symbol(h.symbol), style: context.text.titleSmall)),
                    Text(Fmt.money(h.lastPrice), style: context.text.labelLarge?.tabular),
                    const SizedBox(width: AppSpace.md),
                    SizedBox(
                      width: 66,
                      child: PnlPercent(
                        h.pnlPercent,
                        style: context.text.labelMedium,
                        showArrow: false,
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }
}
