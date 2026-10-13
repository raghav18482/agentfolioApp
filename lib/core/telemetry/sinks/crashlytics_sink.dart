import 'dart:async';

import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/telemetry/telemetry_sink.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Crash reports, with the user's recent steps attached.
///
/// Events, screens and log lines become Crashlytics breadcrumbs (`log`), so
/// every crash arrives with the taps, screens and API calls that led to it.
/// Crashlytics is not an analytics tool, so this sink ignores the analytics
/// opt-out: crash reporting stays on.
class CrashlyticsSink extends TelemetrySink {
  CrashlyticsSink(this._crashlytics, {required this.collectionEnabled});

  final FirebaseCrashlytics _crashlytics;

  /// Off in dev builds so test crashes never reach production reports.
  final bool collectionEnabled;

  @override
  String get name => 'crashlytics';

  @override
  Future<void> init() => _crashlytics.setCrashlyticsCollectionEnabled(collectionEnabled);

  @override
  void track(TelemetryEvent event) => unawaited(_crashlytics.log(event.toString()));

  @override
  void screen(String name, {String? previous}) {
    unawaited(_crashlytics.log('screen $name'));
    unawaited(_crashlytics.setCustomKey('screen', name));
  }

  @override
  void breadcrumb(String message, {Map<String, Object?> data = const {}}) =>
      unawaited(_crashlytics.log(data.isEmpty ? message : '$message $data'));

  @override
  void recordError(
    Object error,
    StackTrace? stack, {
    required bool fatal,
    String? reason,
    Map<String, Object?> context = const {},
  }) {
    unawaited(
      _crashlytics.recordError(
        error,
        stack,
        fatal: fatal,
        reason: reason,
        information: [for (final e in context.entries) '${e.key}: ${e.value}'],
      ),
    );
  }

  @override
  void identify(TelemetryUser user) => unawaited(_crashlytics.setUserIdentifier(user.id));

  @override
  void setGlobalProperties(Map<String, Object?> properties) {
    for (final MapEntry(:key, :value) in properties.entries) {
      unawaited(_crashlytics.setCustomKey(key, value is num || value is bool ? value! : '$value'));
    }
  }

  @override
  void reset() => unawaited(_crashlytics.setUserIdentifier(''));
}
