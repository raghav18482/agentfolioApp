import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/telemetry/telemetry_sink.dart';

/// A sink that remembers everything it receives, for assertions.
class RecordingSink extends TelemetrySink {
  RecordingSink({this.analytics = false, this.throwOnTrack = false});

  final bool analytics;
  final bool throwOnTrack;

  final events = <TelemetryEvent>[];
  final screens = <String>[];
  final breadcrumbs = <String>[];
  final errors = <({Object error, bool fatal, Map<String, Object?> context})>[];
  final users = <TelemetryUser>[];
  final globals = <Map<String, Object?>>[];
  int resets = 0;

  @override
  String get name => 'recording';

  @override
  bool get isAnalytics => analytics;

  @override
  void track(TelemetryEvent event) {
    if (throwOnTrack) throw StateError('sink exploded');
    events.add(event);
  }

  @override
  void screen(String name, {String? previous}) => screens.add(name);

  @override
  void breadcrumb(String message, {Map<String, Object?> data = const {}}) =>
      breadcrumbs.add(message);

  @override
  void recordError(
    Object error,
    StackTrace? stack, {
    required bool fatal,
    String? reason,
    Map<String, Object?> context = const {},
  }) => errors.add((error: error, fatal: fatal, context: context));

  @override
  void identify(TelemetryUser user) => users.add(user);

  @override
  void setGlobalProperties(Map<String, Object?> properties) => globals.add(properties);

  @override
  void reset() => resets++;

  Iterable<TelemetryEvent> named(String name) => events.where((e) => e.name == name);
}

/// A ready [Telemetry] over one [RecordingSink].
Future<(Telemetry, RecordingSink)> recordingTelemetry() async {
  final sink = RecordingSink();
  final telemetry = Telemetry(sinks: [sink]);
  await telemetry.init();
  return (telemetry, sink);
}
