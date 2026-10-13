import 'dart:io' show HttpDate, HttpException;

import 'package:dio/dio.dart';

/// The server's idea of now, for countdowns to server deadlines.
///
/// A phone's clock can be minutes off. A proposal that expires five minutes
/// after the server created it must count down by the server's clock, or the
/// app would offer to approve one the server already treats as expired.
/// Learned from each response's `Date` header (one-second resolution, which
/// is plenty for a countdown).
class ServerClock {
  ServerClock({DateTime Function()? deviceNow}) : _deviceNow = deviceNow ?? DateTime.now;

  final DateTime Function() _deviceNow;
  Duration _offset = Duration.zero;

  /// Server time minus device time.
  Duration get offset => _offset;

  DateTime now() => _deviceNow().add(_offset);

  void observe(DateTime serverTime) => _offset = serverTime.difference(_deviceNow());

  void observeHeader(String? httpDate) {
    if (httpDate == null) return;
    try {
      observe(HttpDate.parse(httpDate));
    } on FormatException {
      // A malformed header teaches us nothing.
    } on HttpException {
      // Same.
    }
  }
}

/// Feeds every response's `Date` header to the [ServerClock].
class ServerClockInterceptor extends Interceptor {
  ServerClockInterceptor(this._clock);

  final ServerClock _clock;

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _clock.observeHeader(response.headers.value('date'));
    handler.next(response);
  }
}
