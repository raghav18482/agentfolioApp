import 'dart:developer' as developer;

import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/telemetry/telemetry_sink.dart';

/// Prints telemetry to the debug console. Dev builds only.
class ConsoleSink extends TelemetrySink {
  @override
  String get name => 'console';

  @override
  void track(TelemetryEvent event) => _log('event  $event');

  @override
  void screen(String name, {String? previous}) => _log('screen $name  (from ${previous ?? '—'})');

  @override
  void breadcrumb(String message, {Map<String, Object?> data = const {}}) =>
      _log(data.isEmpty ? 'log    $message' : 'log    $message $data');

  @override
  void recordError(
    Object error,
    StackTrace? stack, {
    required bool fatal,
    String? reason,
    Map<String, Object?> context = const {},
  }) {
    developer.log(
      '${fatal ? 'FATAL' : 'error'}  ${reason ?? ''} $context',
      name: 'telemetry',
      error: error,
      stackTrace: stack,
      level: 1000,
    );
  }

  @override
  void identify(TelemetryUser user) => _log('user   ${user.id}');

  @override
  void setGlobalProperties(Map<String, Object?> properties) => _log('global $properties');

  @override
  void reset() => _log('reset');

  void _log(String line) => developer.log(line, name: 'telemetry');
}
