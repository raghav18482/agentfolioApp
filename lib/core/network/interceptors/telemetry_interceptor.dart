import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:dio/dio.dart';

/// Records every API call: method, path template, status and latency.
///
/// Query strings and bodies are never recorded. They carry symbols, phone
/// numbers, passwords and chat text. Ids in the path are collapsed to `:id`,
/// so `/api/agent/threads/42` and `/api/agent/threads/43` count as one endpoint.
class TelemetryInterceptor extends Interceptor {
  TelemetryInterceptor(this._telemetry);

  final Telemetry _telemetry;
  static const _startedKey = 'telemetry_started';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedKey] = DateTime.now().microsecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _record(response.requestOptions, status: response.statusCode);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    _record(err.requestOptions, status: status, error: err.type.name);
    // A 5xx we did not expect is a bug somewhere: report it with its context.
    if (status != null && status >= 500 && status != 502 && status != 503) {
      _telemetry.error(
        err,
        err.stackTrace,
        reason:
            'HTTP $status ${err.requestOptions.method} ${pathTemplate(err.requestOptions.path)}',
      );
    }
    handler.next(err);
  }

  void _record(RequestOptions options, {int? status, String? error}) {
    final started = options.extra[_startedKey] as int?;
    final elapsed = started == null
        ? null
        : (DateTime.now().microsecondsSinceEpoch - started) ~/ 1000;
    _telemetry.track(
      TelemetryEvent(EventName.apiRequested, {
        'method': options.method,
        'path': pathTemplate(options.path),
        'status': ?status,
        'duration_ms': ?elapsed,
        'error': ?error,
        'retry': ?options.extra['retry_attempt'],
      }),
    );
  }

  /// `/api/trading/proposals/a1b2c3d4/approve` → `/api/trading/proposals/:id/approve`.
  static String pathTemplate(String path) {
    final uri = Uri.tryParse(path);
    final segments = (uri?.path ?? path).split('/');
    return segments.map((s) => _looksLikeId(s) ? ':id' : s).join('/');
  }

  static bool _looksLikeId(String segment) =>
      RegExp(r'^\d+$').hasMatch(segment) ||
      (segment.length >= 6 && RegExp(r'\d').hasMatch(segment) && !segment.contains('_'));
}
