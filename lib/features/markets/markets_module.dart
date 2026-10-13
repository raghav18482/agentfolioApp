import 'package:agentfolio/features/markets/data/datasources/markets_remote_data_source.dart';
import 'package:agentfolio/features/markets/data/repositories/markets_repository_impl.dart';
import 'package:agentfolio/features/markets/domain/repositories/markets_repository.dart';
import 'package:agentfolio/features/markets/presentation/view_models/markets_view_model.dart';
import 'package:get_it/get_it.dart';

/// Wires the Markets tab: portfolio news and sentiment, news search, market
/// breadth and the user's sectors.
void registerMarketsFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => MarketsRemoteDataSource(sl()))
    ..registerLazySingleton<MarketsRepository>(() => MarketsRepositoryImpl(sl(), sl()))
    ..registerFactory(() => MarketsViewModel(markets: sl(), portfolio: sl(), telemetry: sl()));
}
