import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/logic/price_history_logic.dart';
import 'package:flutter_test/flutter_test.dart';

PriceHistory history(List<DateTime> dates, List<double> closes) => PriceHistory(
  dates: dates,
  bars: [for (final c in closes) Ohlc(open: c, high: c, low: c, close: c)],
  volumes: [for (final _ in closes) 0],
  sma50: [for (final _ in closes) null],
  sma200: [for (final _ in closes) null],
  rsi: [for (final _ in closes) null],
  macd: [for (final _ in closes) null],
  macdSignal: [for (final _ in closes) null],
  macdHistogram: [for (final _ in closes) null],
);

void main() {
  group('rangeStart', () {
    final dates = [for (var i = 0; i < 365; i++) DateTime(2025, 3).add(Duration(days: i))];

    test('starts at the first day on or after the same date N months back', () {
      final last = dates.last;
      for (final range in [ChartRange.month, ChartRange.quarter, ChartRange.half]) {
        final start = rangeStart(dates, range);
        final boundary = DateTime(last.year, last.month - range.months, last.day);
        expect(dates[start].isBefore(boundary), isFalse, reason: range.name);
        expect(dates[start - 1].isBefore(boundary), isTrue, reason: range.name);
      }
      expect(rangeStart(dates, ChartRange.year), 0);
    });

    test('a short history shows in full for a long range', () {
      expect(rangeStart(dates.sublist(300), ChartRange.year), 0);
      expect(rangeStart(const [], ChartRange.month), 0);
    });
  });

  group('dayChange', () {
    final days = [DateTime(2026, 3, 9), DateTime(2026, 3, 10), DateTime(2026, 3, 11)];

    test('is the last price against the close before the latest session', () {
      final change = dayChange(history(days, [100, 200, 210]), ltp: 220)!;
      expect(change.amount, 20);
      expect(change.percent, 10);
    });

    test('needs at least two sessions', () {
      expect(dayChange(history(days.sublist(2), [100]), ltp: 100), isNull);
    });

    test('a zero previous close gives no percentage rather than infinity', () {
      expect(dayChange(history(days, [1, 0, 5]), ltp: 5), isNull);
    });
  });

  group('pivotLadder', () {
    const levels = PivotLevels(pivot: 100, r1: 110, r2: 120, s1: 90, s2: 80);

    List<String> names(List<LadderRung> rungs) => [
      for (final r in rungs)
        switch (r) {
          LevelRung(:final level) => level.name,
          CurrentRung() => 'now',
        },
    ];

    test('slots the price between the levels around it', () {
      expect(names(pivotLadder(levels, 105)), ['r2', 'r1', 'now', 'pivot', 's1', 's2']);
    });

    test('above every level, the price leads; below, it trails', () {
      expect(names(pivotLadder(levels, 130)).first, 'now');
      expect(names(pivotLadder(levels, 70)).last, 'now');
    });

    test('missing levels are skipped, and no price means no marker', () {
      expect(names(pivotLadder(const PivotLevels(pivot: 100, s1: 90), 0)), ['pivot', 's1']);
    });
  });

  test('tallySignals counts each status', () {
    TechnicalSignal s(SignalStatus status) =>
        TechnicalSignal(name: '', status: status, value: '', label: '');
    final tally = tallySignals([
      s(SignalStatus.bullish),
      s(SignalStatus.bullish),
      s(SignalStatus.bearish),
      s(SignalStatus.neutral),
    ]);
    expect((tally.bullish, tally.bearish, tally.neutral), (2, 1, 1));
  });
}
