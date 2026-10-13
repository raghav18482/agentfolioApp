import 'package:intl/intl.dart';

/// Times as the user should read them. Ported from the web app's
/// `utils/time.ts`. Market times are always India time, whatever the device's
/// time zone, because that is when the market opens.
abstract final class Times {
  /// India has no daylight saving, so a fixed offset is exact.
  static const istOffset = Duration(hours: 5, minutes: 30);

  static final _istDateTime = DateFormat('dd MMM, hh:mm a');
  static final _istClock = DateFormat('HH:mm');

  /// Server timestamps are UTC ISO strings. Some older paths omit the offset,
  /// which `DateTime.parse` would read as local time; those are treated as UTC.
  static DateTime? parseServer(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    final hasZone = RegExp(r'([zZ]|[+-]\d{2}:?\d{2})$').hasMatch(iso);
    return DateTime.tryParse(hasZone ? iso : '${iso}Z')?.toUtc();
  }

  /// The wall-clock time in India for [utc], as a DateTime whose fields read
  /// as IST. For display only.
  static DateTime toIst(DateTime utc) => utc.toUtc().add(istOffset);

  /// `08 Jan, 08:30 AM` in India time, or `—`.
  static String formatIst(String? iso) {
    final date = parseServer(iso);
    return date == null ? '—' : _istDateTime.format(toIst(date));
  }

  /// `HH:mm` in India time.
  static String? istClock(String? iso) {
    final date = parseServer(iso);
    return date == null ? null : _istClock.format(toIst(date));
  }

  /// Whether NSE's regular session is on: weekdays, 09:15–15:30 IST.
  /// Exchange holidays are not known here, so a holiday reads as open; live
  /// views then simply see no ticks.
  static bool isMarketOpen(DateTime utc) {
    final ist = toIst(utc);
    if (ist.weekday == DateTime.saturday || ist.weekday == DateTime.sunday) return false;
    final minutes = ist.hour * 60 + ist.minute;
    return minutes >= 9 * 60 + 15 && minutes < 15 * 60 + 30;
  }

  /// `just now`, `5m ago`, `3h ago`, `2d ago`, then a date.
  static String relative(DateTime then, {DateTime? now}) {
    final seconds = (now ?? DateTime.now()).difference(then).inSeconds;
    if (seconds < 60) return 'just now';
    if (seconds < 3600) return '${seconds ~/ 60}m ago';
    if (seconds < 86400) return '${seconds ~/ 3600}h ago';
    if (seconds < 604800) return '${seconds ~/ 86400}d ago';
    return DateFormat('dd MMM yyyy').format(then.toLocal());
  }
}
