import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/telemetry/sinks/console_sink.dart';
import 'package:agentfolio/core/telemetry/sinks/crashlytics_sink.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_sink.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Every telemetry destination the app sends to.
///
/// **This is the one place to add a destination.** For Amplitude: write an
/// `AmplitudeSink extends TelemetrySink` (with `isAnalytics => true`), then add
/// it below. Every event, screen view, tap, API call, log line and error then
/// reaches it with no other change.
List<TelemetrySink> buildTelemetrySinks(Env env, {required bool firebaseReady}) => [
  if (kDebugMode) ConsoleSink(),
  if (firebaseReady)
    CrashlyticsSink(FirebaseCrashlytics.instance, collectionEnabled: env.crashlyticsEnabled),
  // AmplitudeSink(apiKey: env.amplitudeKey),
];

/// Routes every uncaught error and every `package:logging` record into [telemetry].
void installTelemetryHooks(Telemetry telemetry, {required bool verboseLogs}) {
  FlutterError.onError = (details) {
    // Keep the red-screen/console report in debug, and send it everywhere else.
    FlutterError.presentError(details);
    telemetry.error(
      details.exception,
      details.stack,
      fatal: true,
      reason: details.context?.toDescription(),
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    telemetry.error(error, stack, fatal: true, reason: 'Uncaught async error');
    return true;
  };

  Logger.root.level = verboseLogs ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((record) {
    if (verboseLogs) {
      developer.log(
        record.message,
        name: record.loggerName,
        level: record.level.value,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    }
    if (record.level >= Level.SEVERE && record.error != null) {
      telemetry.error(
        record.error!,
        record.stackTrace,
        reason: '${record.loggerName}: ${record.message}',
      );
    } else if (record.level >= Level.INFO) {
      telemetry.breadcrumb('[${record.loggerName}] ${record.message}');
    }
  });
}

/// App version, OS and device model, attached to everything. No identifiers:
/// the device id is never collected.
Future<Map<String, Object?>> collectTelemetryContext(Env env) async {
  final package = await PackageInfo.fromPlatform();
  final device = DeviceInfoPlugin();
  final (model, osVersion) = switch (defaultTargetPlatform) {
    TargetPlatform.android => await device.androidInfo.then(
      (i) => ('${i.manufacturer} ${i.model}', 'Android ${i.version.release}'),
    ),
    TargetPlatform.iOS => await device.iosInfo.then(
      (i) => (i.utsname.machine, '${i.systemName} ${i.systemVersion}'),
    ),
    _ => (Platform.operatingSystem, Platform.operatingSystemVersion),
  };
  return {
    'app_version': package.version,
    'build_number': package.buildNumber,
    'flavor': env.flavor.name,
    'platform': defaultTargetPlatform.name,
    'os_version': osVersion,
    'device_model': model,
    'launch_id': _launchId(),
  };
}

/// Random per launch, so one session's events can be grouped without
/// identifying the device.
String _launchId() {
  final random = Random.secure();
  return List.generate(12, (_) => random.nextInt(16).toRadixString(16)).join();
}
