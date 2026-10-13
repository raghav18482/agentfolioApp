import 'package:agentfolio/features/research/data/datasources/research_remote_data_source.dart';
import 'package:agentfolio/features/research/data/repositories/research_repository_impl.dart';
import 'package:agentfolio/features/research/domain/repositories/research_repository.dart';
import 'package:get_it/get_it.dart';

/// Wires per-stock research: technicals, fundamentals, prediction, the AI
/// summary and the metric glossary. Its screens live in `stock_detail` and
/// `learn`, which register their own view models.
void registerResearchFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => ResearchRemoteDataSource(sl()))
    ..registerLazySingleton<ResearchRepository>(() => ResearchRepositoryImpl(sl(), sl()));
}
