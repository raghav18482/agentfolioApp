import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:agentfolio/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:agentfolio/features/auth/domain/usecases/link_account.dart';
import 'package:agentfolio/features/auth/domain/usecases/login.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/auth/presentation/view_models/link_account_view_model.dart';
import 'package:agentfolio/features/auth/presentation/view_models/login_view_model.dart';
import 'package:get_it/get_it.dart';

/// Wires the auth feature: data source → repository → use cases → state.
void registerAuthFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => AuthRemoteDataSource(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => LinkAccount(sl()))
    ..registerLazySingleton(
      () => SessionProvider(
        repository: sl(),
        cache: sl(),
        epoch: sl(),
        telemetry: sl(),
        expirySignal: sl(),
      ),
    )
    // Screen-scoped: a fresh one each time the screen opens.
    ..registerFactory(
      () => LoginViewModel(repository: sl(), login: sl(), session: sl(), telemetry: sl()),
    )
    ..registerFactory(
      () => LinkAccountViewModel(
        // The only broker today. A broker picker will pass the chosen one.
        broker: sl<BrokerRegistry>().resolve(null),
        repository: sl(),
        linkAccount: sl(),
        session: sl(),
        consentRequired: sl<Env>().hasLegalPages,
        telemetry: sl(),
      ),
    );
}
