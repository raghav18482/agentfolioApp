import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/charts/chart_palette.dart';
import 'package:agentfolio/core/presentation/charts/ring_gauge.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/theme/app_typography.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/logic/portfolio_insights.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Where the money sits: by sector, and invested against cash. Two views in
/// one swipeable card, so Home stays short.
class AllocationCard extends StatefulWidget {
  const AllocationCard({required this.snapshot, required this.sectorMap, super.key});

  final PortfolioSnapshot snapshot;

  /// Null while the sector map loads.
  final SectorMap? sectorMap;

  @override
  State<AllocationCard> createState() => _AllocationCardState();
}

class _AllocationCardState extends State<AllocationCard> {
  final _pages = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titles = [l10n.homeSectorTitle, l10n.homeCashTitle];
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: AppMotion.of(context, AppMotion.short),
                    layoutBuilder: (current, previous) =>
                        Stack(alignment: Alignment.centerLeft, children: [...previous, ?current]),
                    child: Text(
                      titles[_page],
                      key: ValueKey(_page),
                      style: context.text.titleMedium,
                    ),
                  ),
                ),
                _Dots(count: titles.length, index: _page),
              ],
            ),
          ),
          SizedBox(
            // Taller with larger text, so the legend still fits beside the donut.
            height: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.6).scale(200),
            child: PageView(
              controller: _pages,
              onPageChanged: (page) {
                context.trackChange('allocation_page', page == 0 ? 'sector' : 'cash');
                setState(() => _page = page);
              },
              children: [
                _SectorPage(holdings: widget.snapshot.holdings, sectorMap: widget.sectorMap),
                _CashPage(snapshot: widget.snapshot),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectorPage extends StatefulWidget {
  const _SectorPage({required this.holdings, required this.sectorMap});

  final List<Holding> holdings;
  final SectorMap? sectorMap;

  @override
  State<_SectorPage> createState() => _SectorPageState();
}

class _SectorPageState extends State<_SectorPage> {
  int? _touched;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final map = widget.sectorMap;
    if (map == null) {
      return const Padding(
        padding: EdgeInsets.all(AppSpace.lg),
        child: Shimmer(child: SkeletonBox(width: double.infinity, height: 200)),
      );
    }
    final slices = foldSmallSlices(sectorSlices(widget.holdings, map));
    final total = slices.fold<double>(0, (s, x) => s + x.value);
    final focus = _touched == null || _touched! >= slices.length ? null : slices[_touched!];

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.md, AppSpace.lg, 0),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 52,
                    startDegreeOffset: -90,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        if (!event.isInterestedForInteractions) {
                          setState(() => _touched = null);
                          return;
                        }
                        setState(() => _touched = response?.touchedSection?.touchedSectionIndex);
                      },
                    ),
                    sections: [
                      for (final (i, s) in slices.indexed)
                        PieChartSectionData(
                          value: s.value,
                          color: ChartPalette.category(i),
                          radius: i == _touched ? 30 : 24,
                          showTitle: false,
                        ),
                    ],
                  ),
                  duration: AppMotion.of(context, AppMotion.medium),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MoneyText(
                      focus?.value ?? total,
                      format: MoneyStyle.compact,
                      style: context.text.titleSmall,
                    ),
                    Text(
                      focus?.sector ?? l10n.homeTotalValue,
                      style: context.text.labelSmall?.copyWith(letterSpacing: 0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: ListView(
              // Centred when it fits; scrolls when many sectors meet large text.
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                for (final (i, s) in slices.indexed)
                  _LegendRow(
                    color: ChartPalette.category(i),
                    label: s.sector,
                    percent: total == 0 ? 0 : s.value / total * 100,
                    selected: i == _touched,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.percent,
    required this.selected,
  });

  final Color color;
  final String label;
  final double percent;
  final bool selected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: AppSpace.sm),
        Expanded(
          flex: 2,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.bodySmall?.copyWith(
              color: selected ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: AppSpace.sm),
        Flexible(
          child: Text(
            '${percent.toStringAsFixed(1)}%',
            style: context.text.labelMedium?.tabular,
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.end,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    ),
  );
}

class _CashPage extends StatelessWidget {
  const _CashPage({required this.snapshot});

  final PortfolioSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final invested = snapshot.summary.totalInvested ?? 0;
    final cash = snapshot.funds.availableCash ?? 0;
    final total = invested + cash;
    String pct(double v) => total == 0 ? '0%' : '${(v / total * 100).toStringAsFixed(1)}%';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
      child: Row(
        children: [
          RingGauge(
            size: 160,
            semanticLabel: l10n.homeCashSemantics(pct(invested), pct(cash)),
            parts: [
              (value: invested, color: AppColors.indigo),
              (value: cash, color: AppColors.emerald),
            ],
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MoneyText(total, format: MoneyStyle.compact, style: context.text.titleSmall),
                Text(
                  l10n.homeTotalCapital,
                  style: context.text.labelSmall?.copyWith(letterSpacing: 0),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.lg),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CashLegend(
                  color: AppColors.indigo,
                  label: l10n.homeInvested,
                  amount: invested,
                  share: pct(invested),
                ),
                const SizedBox(height: AppSpace.lg),
                _CashLegend(
                  color: AppColors.emerald,
                  label: l10n.homeCash,
                  amount: cash,
                  share: pct(cash),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CashLegend extends StatelessWidget {
  const _CashLegend({
    required this.color,
    required this.label,
    required this.amount,
    required this.share,
  });

  final Color color;
  final String label;
  final double amount;
  final String share;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 4),
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      ),
      const SizedBox(width: AppSpace.sm),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label · $share', style: context.text.labelMedium),
            MoneyText(amount, format: MoneyStyle.rupees, style: context.text.titleSmall),
          ],
        ),
      ),
    ],
  );
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var i = 0; i < count; i++)
        AnimatedContainer(
          duration: AppMotion.of(context, AppMotion.short),
          margin: const EdgeInsets.only(left: 4),
          width: i == index ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: i == index ? AppColors.brandSoft : context.palette.border,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
    ],
  );
}
