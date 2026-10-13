import 'dart:async';

import 'package:agentfolio/app/app.dart';
import 'package:agentfolio/app/di/injector.dart';
import 'package:agentfolio/app/splash/app_startup.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_setup.dart';
import 'package:agentfolio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

/// Everything before the first frame, kept as short as possible: the splash
/// should be on screen fast, and the slow work (session check) runs behind it.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final env = Env.fromEnvironment();

  final firebaseReady = await _initFirebase();
  final telemetry = Telemetry(sinks: buildTelemetrySinks(env, firebaseReady: firebaseReady));
  installTelemetryHooks(telemetry, verboseLogs: kDebugMode);
  // Buffers until ready, so nothing logged during startup is lost.
  unawaited(telemetry.init());

  await configureDependencies(env: env, telemetry: telemetry);
  telemetry.analyticsEnabled = sl<Prefs>().analyticsEnabled;

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlay);

  // Starts the launch work now; the splash shows its progress.
  unawaited(sl<AppStartup>().start());
  runApp(const AgentfolioApp());
}

/// A Firebase failure must not stop the app opening: it only costs crash
/// reporting for this launch.
Future<bool> _initFirebase() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return true;
  } on Object catch (e, s) {
    Logger('Bootstrap').severe('Firebase failed to initialise; crash reporting is off', e, s);
    return false;
  }
}
