import 'package:agentfolio/core/telemetry/telemetry_event.dart';

/// A destination for telemetry: the console, Crashlytics, and later Amplitude.
///
/// Sinks receive data that the redactor has already scrubbed. Each method may
/// be a no-op for a sink that has no use for it; Crashlytics, for example,
/// turns events into breadcrumbs, while an analytics tool records them as
/// events. A sink may throw, and the facade isolates it so one broken sink
/// never affects the others or the app.
abstract class TelemetrySink {
  /// Shown in diagnostics when a sink misbehaves.
  String get name;

  /// Whether this sink records interaction analytics (events, screens). The
  /// user's analytics opt-out silences these sinks but keeps crash reporting.
  bool get isAnalytics => false;

  Future<void> init() async {}

  void track(TelemetryEvent event) {}

  void screen(String name, {String? previous}) {}

  /// A free-form log line leading up to a possible error.
  void breadcrumb(String message, {Map<String, Object?> data = const {}}) {}

  void recordError(
    Object error,
    StackTrace? stack, {
    required bool fatal,
    String? reason,
    Map<String, Object?> context = const {},
  }) {}

  void identify(TelemetryUser user) {}

  /// Properties attached to everything from now on: app version, flavor,
  /// active broker.
  void setGlobalProperties(Map<String, Object?> properties) {}

  /// Forget the user, on logout and account deletion.
  void reset() {}
}
