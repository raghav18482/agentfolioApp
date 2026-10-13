import 'package:agentfolio/app/splash/app_startup.dart';
import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/market/market_stream.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/security/app_lock.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/session/session_epoch.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/storage/first_launch_guard.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/storage/secure_store.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/features/agent/agent_module.dart';
import 'package:agentfolio/features/ai/ai_module.dart';
import 'package:agentfolio/features/auth/auth_module.dart';
import 'package:agentfolio/features/markets/markets_module.dart';
import 'package:agentfolio/features/portfolio/portfolio_module.dart';
import 'package:agentfolio/features/research/research_module.dart';
import 'package:agentfolio/features/stock_detail/stock_detail_module.dart';
import 'package:agentfolio/features/trading/trading_module.dart';
import 'package:get_it/get_it.dart';

/// The service locator for the data and domain graph. Widgets do not reach
/// into it; they get what they need from Provider, which `AgentfolioApp`
/// fills from here.
final GetIt sl = GetIt.instance;

Future<void> configureDependencies({required Env env, required Telemetry telemetry}) async {
  final prefs = await Prefs.create();

  sl
    ..registerSingleton(env)
    ..registerSingleton(telemetry)
    ..registerSingleton(prefs)
    ..registerLazySingleton(SecureStore.new)
    ..registerLazySingleton(SessionEpoch.new)
    ..registerLazySingleton(SessionExpirySignal.new)
    ..registerLazySingleton(RequestCache.new)
    ..registerLazySingleton(ServerClock.new)
    ..registerLazySingleton<DeviceAuth>(LocalDeviceAuth.new)
    ..registerLazySingleton(BrokerRegistry.new)
    ..registerLazySingleton(() => FirstLaunchGuard(sl(), sl()))
    ..registerLazySingleton(() => LinkOpener(sl()))
    ..registerLazySingleton(() => PrivacyProvider(sl()))
    ..registerLazySingleton(
      () => ApiClient.create(
        baseUrl: env.apiBaseUrl,
        secureStore: sl(),
        telemetry: sl(),
        sessionExpiry: sl(),
        serverClock: sl(),
      ),
    )
    ..registerLazySingleton(() => MarketStream(sl()), dispose: (s) => s.dispose());

  // One line per feature. Each feature wires its own data → domain → state.
  registerAuthFeature(sl);
  registerPortfolioFeature(sl);
  registerResearchFeature(sl);
  registerStockDetailFeature(sl);
  registerMarketsFeature(sl);
  registerAiFeature(sl);
  registerAgentFeature(sl);
  registerTradingFeature(sl);

  // Created with the app (see AgentfolioApp), so it sees the session being
  // restored at launch and locks it.
  sl.registerLazySingleton(() => AppLock(prefs: sl(), auth: sl(), session: sl(), telemetry: sl()));

  sl.registerLazySingleton(
    () => AppStartup(env: sl(), firstLaunchGuard: sl(), session: sl(), telemetry: sl()),
  );
}
