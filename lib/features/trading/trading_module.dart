import 'package:agentfolio/features/trading/data/datasources/trading_remote_data_source.dart';
import 'package:agentfolio/features/trading/data/repositories/trading_repository_impl.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/repositories/trading_repository.dart';
import 'package:agentfolio/features/trading/presentation/view_models/live_watch_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/premium_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/rebalancer_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/risk_profile_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:get_it/get_it.dart';

/// Wires the Trade tab: proposals and approval, live prices, the risk
/// profile, the daily brief, Premium, and the what-if rebalancer.
void registerTradingFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => TradingRemoteDataSource(sl()))
    ..registerLazySingleton<TradingRepository>(() => TradingRepositoryImpl(sl(), sl()))
    ..registerFactory(() => TradeViewModel(trading: sl(), telemetry: sl()))
    ..registerFactory(
      () => LiveWatchViewModel(portfolio: sl(), research: sl(), stream: sl(), telemetry: sl()),
    )
    ..registerFactory(
      () => PremiumViewModel(trading: sl(), auth: sl(), session: sl(), telemetry: sl()),
    )
    ..registerFactory(() => RebalancerViewModel(portfolio: sl(), telemetry: sl()))
    ..registerFactoryParam<RiskProfileViewModel, RiskProfile?, void>(
      (initial, _) => RiskProfileViewModel(trading: sl(), telemetry: sl(), initial: initial),
    );
}
