import 'package:flutter_movie_db/core/auth/bloc/auth_bloc.dart';
import 'package:flutter_movie_db/core/auth/repositories/auth_repository.dart';
import 'package:flutter_movie_db/core/auth/use_cases/login_use_case.dart';
import 'package:flutter_movie_db/core/auth/use_cases/register_use_case.dart';
import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/features/auth/data/data_sources/auth_data_source.dart';
import 'package:flutter_movie_db/features/auth/repositories/auth_repository_impl.dart';

void authInjections() {

  // Data Sources
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl()
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: getIt())
    );

  // Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: getIt())
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(authRepository: getIt())
  );

  // BLoC
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt(),
      registerUseCase: getIt(),
    )
  );
}