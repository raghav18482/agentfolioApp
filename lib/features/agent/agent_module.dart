import 'package:agentfolio/features/agent/data/datasources/agent_remote_data_source.dart';
import 'package:agentfolio/features/agent/data/repositories/agent_repository_impl.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/domain/repositories/agent_repository.dart';
import 'package:agentfolio/features/agent/presentation/view_models/agent_chat_view_model.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:get_it/get_it.dart';

/// Wires the Agent tab: the finance and trading agents and their saved
/// conversations.
void registerAgentFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => AgentRemoteDataSource(sl()))
    ..registerLazySingleton<AgentRepository>(() => AgentRepositoryImpl(sl(), sl()))
    ..registerFactoryParam<AgentChatViewModel, AgentType, void>(
      (type, _) => AgentChatViewModel(
        type: type,
        agent: sl(),
        prefs: sl(),
        userId: sl<SessionProvider>().signedIn?.user.id,
        telemetry: sl(),
      ),
    );
}
