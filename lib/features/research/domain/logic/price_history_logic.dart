import 'package:agentfolio/features/research/domain/entities/technicals.dart';

/// Chart windows a phone can read. Cut from the one year the technical
/// endpoint returns, so switching range never makes a request.
enum ChartRange {
  month(1),
  quarter(3),
  half(6),
  year(12);

  ChartRange(this.months);

  final int months;
}

/// The first bar inside [range], counted back from the last bar's date.
int rangeStart(List<DateTime> dates, ChartRange range) {
  if (dates.isEmpty) return 0;
  final last = dates.last;
  final from = DateTime(last.year, last.month - range.months, last.day);
  final index = dates.indexWhere((d) => !d.isBefore(from));
  return index < 0 ? 0 : index;
}

/// A price move: absolute and percent.
typedef PriceChange = ({double amount, double percent});

PriceChange? changeBetween(double from, double to) =>
    from == 0 ? null : (amount: to - from, percent: (to - from) / from * 100);

/// The latest session's move: [ltp] against the close before it.
///
/// During market hours the last bar is today's own, so the one before it is
/// yesterday's close. After the close, at weekends and before the open, [ltp]
/// is the last session's close, and this is that session's move: what a
/// "1D" label promises.
PriceChange? dayChange(PriceHistory history, {required double ltp}) =>
    history.length < 2 ? null : changeBetween(history.bars[history.length - 2].close, ltp);

/// A rung on the support/resistance ladder: a pivot level, or where the
/// price is now.
sealed class LadderRung {
  const LadderRung(this.price);
  final double price;
}

final class LevelRung extends LadderRung {
  const LevelRung(this.level, super.price);
  final PivotLevel level;
}

final class CurrentRung extends LadderRung {
  const CurrentRung(super.price);
}

enum PivotLevel { r2, r1, pivot, s1, s2 }

/// The pivot levels highest first, with the current price slotted in where
/// it sits, so the screen shows at a glance which levels are above and below.
List<LadderRung> pivotLadder(PivotLevels levels, double price) {
  final rungs = <LadderRung>[
    for (final (level, value) in [
      (PivotLevel.r2, levels.r2),
      (PivotLevel.r1, levels.r1),
      (PivotLevel.pivot, levels.pivot),
      (PivotLevel.s1, levels.s1),
      (PivotLevel.s2, levels.s2),
    ])
      if (value != null) LevelRung(level, value),
  ]..sort((a, b) => b.price.compareTo(a.price));
  if (price <= 0) return rungs;
  final at = rungs.indexWhere((r) => r.price < price);
  rungs.insert(at < 0 ? rungs.length : at, CurrentRung(price));
  return rungs;
}

/// How the signals split, for the summary bar.
typedef SignalTally = ({int bullish, int bearish, int neutral});

SignalTally tallySignals(List<TechnicalSignal> signals) => (
  bullish: signals.where((s) => s.status == SignalStatus.bullish).length,
  bearish: signals.where((s) => s.status == SignalStatus.bearish).length,
  neutral: signals.where((s) => s.status == SignalStatus.neutral).length,
);
