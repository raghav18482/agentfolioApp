import 'package:agentfolio/features/ai/data/datasources/ai_remote_data_source.dart';
import 'package:agentfolio/features/ai/data/repositories/ai_key_repository_impl.dart';
import 'package:agentfolio/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_key_repository.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_repository.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ai_insights_view_model.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ask_view_model.dart';
import 'package:get_it/get_it.dart';

/// Wires the features that use the user's own OpenRouter key: Home insights
/// and Ask, and the key and model settings.
void registerAiFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => AiRemoteDataSource(sl()))
    ..registerLazySingleton<AiRepository>(() => AiRepositoryImpl(sl(), sl()))
    ..registerLazySingleton<AiKeyRepository>(() => AiKeyRepositoryImpl(sl(), sl()))
    ..registerLazySingleton(() => AiKeyProvider(repository: sl(), session: sl(), telemetry: sl()))
    ..registerFactory(() => AiInsightsViewModel(ai: sl(), aiKey: sl(), telemetry: sl()))
    ..registerFactory(() => AskViewModel(ai: sl(), aiKey: sl(), telemetry: sl()));
}
