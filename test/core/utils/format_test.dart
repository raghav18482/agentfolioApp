import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fmt', () {
    test('Indian digit grouping', () {
      expect(Fmt.money(12345678.9), '₹1,23,45,678.90');
      expect(Fmt.rupees(123456.7), '₹1,23,457');
      expect(Fmt.money(-950), '-₹950.00');
    });

    test('compact lakh and crore', () {
      expect(Fmt.compact(12500000), '₹1.25 Cr');
      expect(Fmt.compact(430000), '₹4.30 L');
      expect(Fmt.compact(85000), '₹85,000');
      expect(Fmt.compact(-430000), '-₹4.30 L');
    });

    test('a tiny negative is never shown as -0.00', () {
      expect(Fmt.money(-0.004), '₹0.00');
      expect(Fmt.signedPct(-0.001), '0.00%');
      expect(Fmt.signedMoney(-0.001), '₹0.00');
    });

    test('signed values always carry their sign', () {
      expect(Fmt.signedPct(1.234), '+1.23%');
      expect(Fmt.signedPct(-0.4), '-0.40%');
      expect(Fmt.signedMoney(1234.5), '+₹1,234.50');
      expect(Fmt.signedMoney(-80), '-₹80.00');
    });

    test('missing figures are a dash, never ₹0', () {
      expect(Fmt.money(null), '—');
      expect(Fmt.compact(null), '—');
      expect(Fmt.signedPct(null), '—');
    });

    test('broker amounts arrive as numbers, strings or N/A', () {
      expect(Fmt.parseAmount(12.5), 12.5);
      expect(Fmt.parseAmount(' 1200.50 '), 1200.5);
      expect(Fmt.parseAmount('N/A'), isNull);
      expect(Fmt.parseAmount(null), isNull);
      expect(Fmt.parseAmount(double.nan), isNull);
    });

    test('the equity-series suffix is dropped for display', () {
      expect(Fmt.symbol('RELIANCE-EQ'), 'RELIANCE');
      expect(Fmt.symbol('BAJAJ-AUTO'), 'BAJAJ-AUTO');
    });
  });

  group('Times', () {
    test('an offset-less server time is UTC, not local', () {
      expect(Times.parseServer('2026-01-08T03:00:00'), DateTime.utc(2026, 1, 8, 3));
      expect(Times.parseServer('2026-01-08T03:00:00+00:00'), DateTime.utc(2026, 1, 8, 3));
      expect(Times.parseServer('nonsense'), isNull);
    });

    test('India time is UTC+5:30', () {
      expect(Times.istClock('2026-01-08T03:00:00Z'), '08:30');
    });

    test('relative time', () {
      final now = DateTime(2026, 10, 11, 12);
      expect(Times.relative(now.subtract(const Duration(seconds: 20)), now: now), 'just now');
      expect(Times.relative(now.subtract(const Duration(minutes: 5)), now: now), '5m ago');
      expect(Times.relative(now.subtract(const Duration(hours: 3)), now: now), '3h ago');
      expect(Times.relative(now.subtract(const Duration(days: 2)), now: now), '2d ago');
    });
  });
}
