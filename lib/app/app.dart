import 'package:agentfolio/app/di/injector.dart';
import 'package:agentfolio/app/router/app_router.dart';
import 'package:agentfolio/app/splash/app_startup.dart';
import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/market/market_stream.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/security/app_lock.dart';
import 'package:agentfolio/core/security/app_shield.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AgentfolioApp extends StatefulWidget {
  const AgentfolioApp({super.key});

  @override
  State<AgentfolioApp> createState() => _AgentfolioAppState();
}

class _AgentfolioAppState extends State<AgentfolioApp> {
  late final Telemetry _telemetry = sl();
  late final GoRouter _router = buildRouter(
    startup: sl(),
    session: sl(),
    prefs: sl(),
    telemetry: _telemetry,
  );
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () {
        _telemetry.track(const TelemetryEvent(EventName.appForegrounded));
        sl<MarketStream>().resume();
      },
      // No live prices in the background: no data, no battery, no socket.
      onHide: () {
        _telemetry.track(const TelemetryEvent(EventName.appBackgrounded));
        sl<MarketStream>().pause();
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<Env>.value(value: sl()),
      Provider<Telemetry>.value(value: _telemetry),
      Provider<Prefs>.value(value: sl()),
      Provider<BrokerRegistry>.value(value: sl()),
      Provider<LinkOpener>.value(value: sl()),
      Provider<DeviceAuth>.value(value: sl()),
      Provider<ServerClock>.value(value: sl()),
      ChangeNotifierProvider<SessionProvider>.value(value: sl()),
      ChangeNotifierProvider<PrivacyProvider>.value(value: sl()),
      // Created with the app, so its sign-out cleanup is registered before
      // anyone can sign out.
      ChangeNotifierProvider<AiKeyProvider>.value(value: sl()),
      ChangeNotifierProvider<AppLock>.value(value: sl()),
      ChangeNotifierProvider<AppStartup>.value(value: sl()),
    ],
    child: MaterialApp.router(
      title: 'Agentfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Honour the user's text size up to 2×, beyond which layouts built for
      // numbers stop making sense.
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        maxScaleFactor: 2,
        // The app-switcher cover and the app lock sit above every route.
        child: AppShield(child: child ?? const SizedBox.shrink()),
      ),
    ),
  );
}
