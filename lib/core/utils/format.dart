import 'package:intl/intl.dart';

/// Money and percentage formatting, Indian style. Ported from the web app's
/// `utils/format.ts` so both clients show identical figures.
///
/// Every formatter takes `num?` and returns `—` for null: a figure the broker
/// failed to send is shown as missing, never as a misleading ₹0.
abstract final class Fmt {
  static const missing = '—';

  static final _paise = NumberFormat('#,##,##0.00', 'en_IN');
  static final _rupees = NumberFormat('#,##,##0', 'en_IN');
  static final _plain = NumberFormat('#,##,##0.##', 'en_IN');

  /// `₹1,23,456.78`, `-₹950.00`
  static String money(num? value) => _signed(value, (v) => '₹${_paise.format(v)}');

  /// `₹1,23,457` — whole rupees, for big totals and chart labels.
  static String rupees(num? value) => _signed(value, (v) => '₹${_rupees.format(v)}');

  /// `₹1.25 Cr`, `₹4.30 L`, `₹85,000` — for cards where space is tight.
  static String compact(num? value) => _signed(value, (v) {
    if (v >= 1e7) return '₹${(v / 1e7).toStringAsFixed(2)} Cr';
    if (v >= 1e5) return '₹${(v / 1e5).toStringAsFixed(2)} L';
    return '₹${_rupees.format(v)}';
  });

  /// `₹90,412 Cr`, `₹45.6 Cr`, `₹8.20 L` — company-sized amounts: revenue,
  /// profit, free cash flow.
  static String crores(num? value) => _signed(value, (v) {
    if (v >= 1e9) return '₹${_rupees.format(v / 1e7)} Cr';
    if (v >= 1e7) return '₹${(v / 1e7).toStringAsFixed(1)} Cr';
    if (v >= 1e5) return '₹${(v / 1e5).toStringAsFixed(2)} L';
    return '₹${_rupees.format(v)}';
  });

  /// `12.5%` — a level, not a change, so no sign is forced.
  static String percent(num? value, {int decimals = 1}) =>
      value == null ? missing : '${_clean(value, decimals: decimals).toStringAsFixed(decimals)}%';

  /// `24.1x` — a multiple.
  static String multiple(num? value) => value == null ? missing : '${_plain.format(value)}x';

  /// `+₹1,234.50` / `-₹80.00` — a change, so the sign is always shown.
  static String signedMoney(num? value) {
    if (value == null) return missing;
    final v = _clean(value);
    return v > 0 ? '+${money(v)}' : money(v);
  }

  /// `+₹1,235` / `-₹80` — a change in whole rupees.
  static String signedRupees(num? value) {
    if (value == null) return missing;
    final v = _clean(value, decimals: 0);
    return v > 0 ? '+${rupees(v)}' : rupees(v);
  }

  /// `+1.25%` / `-0.40%`
  static String signedPct(num? value, {int decimals = 2}) {
    if (value == null) return missing;
    final v = _clean(value, decimals: decimals);
    return '${v > 0 ? '+' : ''}${v.toStringAsFixed(decimals)}%';
  }

  /// `1,250` / `12.5` — quantities and plain numbers.
  static String number(num? value) => value == null ? missing : _plain.format(value);

  /// `2,450` / `84.35` — a chart axis value: whole rupees once they are big
  /// enough that paise are noise.
  static String axis(num value) =>
      value.abs() >= 1000 ? _rupees.format(value) : _plain.format(value);

  /// `RELIANCE-EQ` → `RELIANCE`: the equity-series suffix is noise on screen.
  static String symbol(String symbol) => symbol.replaceFirst(RegExp(r'-EQ$'), '');

  /// A broker amount, which Angel One sends as a number, a numeric string, or
  /// `"N/A"`. Null when there is nothing real to show.
  static double? parseAmount(Object? value) => switch (value) {
    final num n when n.isFinite => n.toDouble(),
    final String s => double.tryParse(s.trim()),
    _ => null,
  };

  static String _signed(num? value, String Function(double abs) format) {
    if (value == null) return missing;
    final v = _clean(value);
    return v < 0 ? '-${format(-v)}' : format(v);
  }

  /// Rounds to [decimals] so a tiny negative such as -0.004 shows as 0.00,
  /// never "-0.00".
  static double _clean(num value, {int decimals = 2}) {
    final factor = _pow10(decimals);
    final rounded = (value * factor).round() / factor;
    return rounded == 0 ? 0 : rounded;
  }

  static double _pow10(int n) {
    var result = 1.0;
    for (var i = 0; i < n; i++) {
      result *= 10;
    }
    return result;
  }
}
