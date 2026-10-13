import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("countdowns follow the server's clock, not a phone that is wrong", () {
    var device = DateTime.utc(2026, 10, 12, 4);
    final clock = ServerClock(deviceNow: () => device);
    expect(clock.now(), device);

    // The phone runs three minutes fast.
    clock.observeHeader('Mon, 12 Oct 2026 03:57:00 GMT');
    expect(clock.offset, const Duration(minutes: -3));
    device = device.add(const Duration(seconds: 30));
    expect(clock.now(), DateTime.utc(2026, 10, 12, 3, 57, 30));

    clock
      ..observeHeader('not a date')
      ..observeHeader(null);
    expect(clock.offset, const Duration(minutes: -3));
  });

  test('NSE hours are weekdays 09:15–15:30 India time, wherever the phone is', () {
    bool open(int d, int h, int m) => Times.isMarketOpen(DateTime.utc(2026, 10, d, h, m));
    // Monday 12 Oct: 09:15 IST is 03:45 UTC, 15:30 IST is 10:00 UTC.
    expect(open(12, 3, 44), isFalse);
    expect(open(12, 3, 45), isTrue);
    expect(open(12, 9, 59), isTrue);
    expect(open(12, 10, 0), isFalse);
    // Saturday 10 Oct, mid-session hours.
    expect(open(10, 6, 0), isFalse);
  });
}
