import 'package:agentfolio/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:agentfolio/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/home_view_model.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/portfolio_view_model.dart';
import 'package:get_it/get_it.dart';

/// Wires the portfolio feature: holdings, positions, orders, benchmark.
void registerPortfolioFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => PortfolioRemoteDataSource(sl()))
    ..registerLazySingleton<PortfolioRepository>(() => PortfolioRepositoryImpl(sl(), sl()))
    ..registerFactory(() => HomeViewModel(repository: sl(), telemetry: sl()))
    ..registerFactory(() => PortfolioViewModel(repository: sl(), telemetry: sl()));
}
