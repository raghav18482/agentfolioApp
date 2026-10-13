import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';

/// Pure calculations over a portfolio, shared by the charts and lists. Ported
/// from the web app's chart option builders so both clients agree.

/// The [n] best and [n] worst holdings by absolute P&L, without counting a
/// holding twice in a small portfolio. Best first.
({List<Holding> gainers, List<Holding> losers}) topMovers(List<Holding> holdings, {int n = 5}) {
  final ranked = holdings.where((h) => h.invested > 0).toList()
    ..sort((a, b) => b.pnl.compareTo(a.pnl));
  final gainers = ranked.where((h) => h.pnl > 0).take(n).toList();
  final losers = ranked.reversed.where((h) => h.pnl < 0).take(n).toList();
  return (gainers: gainers, losers: losers);
}

/// Current value per sector, largest first. Every holding counts: unmapped
/// symbols land in "Other", so the slices always add up to the portfolio.
List<({String sector, double value})> sectorSlices(List<Holding> holdings, SectorMap map) {
  final totals = <String, double>{};
  for (final h in holdings) {
    final sector = map[h.symbol] ?? 'Other';
    totals[sector] = (totals[sector] ?? 0) + h.currentValue;
  }
  final slices = [
    for (final e in totals.entries)
      if (e.value > 0) (sector: e.key, value: e.value),
  ]..sort((a, b) => b.value.compareTo(a.value));
  return slices;
}

/// Folds the smallest slices into "Other" so a donut stays readable on a
/// phone: at most [max] slices.
List<({String sector, double value})> foldSmallSlices(
  List<({String sector, double value})> slices, {
  int max = 7,
}) {
  if (slices.length <= max) return slices;
  final kept = slices.take(max - 1).toList();
  final rest = slices.skip(max - 1).fold<double>(0, (sum, s) => sum + s.value);
  final existingOther = kept.indexWhere((s) => s.sector == 'Other');
  if (existingOther >= 0) {
    final other = kept.removeAt(existingOther);
    return [...kept, (sector: 'Other', value: other.value + rest)];
  }
  return [...kept, (sector: 'Other', value: rest)];
}

enum HoldingSort { currentValue, pnl, pnlPercent, invested, name }

/// Holdings matching [query] (symbol, case-insensitive), in [sort] order.
List<Holding> arrangeHoldings(
  List<Holding> holdings, {
  required HoldingSort sort,
  String query = '',
}) {
  final q = query.trim().toUpperCase();
  final filtered = q.isEmpty
      ? [...holdings]
      : holdings.where((h) => h.displaySymbol.toUpperCase().contains(q)).toList();
  int byDesc(double a, double b) => b.compareTo(a);
  filtered.sort(switch (sort) {
    HoldingSort.currentValue => (a, b) => byDesc(a.currentValue, b.currentValue),
    HoldingSort.pnl => (a, b) => byDesc(a.pnl, b.pnl),
    HoldingSort.pnlPercent => (a, b) => byDesc(a.pnlPercent, b.pnlPercent),
    HoldingSort.invested => (a, b) => byDesc(a.invested, b.invested),
    HoldingSort.name => (a, b) => a.displaySymbol.compareTo(b.displaySymbol),
  });
  return filtered;
}
