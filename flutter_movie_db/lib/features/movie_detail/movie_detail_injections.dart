import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/features/movie_detail/data/data_sources/movie_detail_api.dart';
import 'package:flutter_movie_db/features/movie_detail/data/repositories/movie_detail_repository_impl.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/repositories/movie_detail_repository.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/use_cases/get_movie_detail_use_case.dart';
import 'package:flutter_movie_db/features/movie_detail/presenter/bloc/movie_detail_bloc.dart';

void movieDetailInjections() {
  // Data Sources
  getIt.registerLazySingleton<MovieDetailApi>(
    () => MovieDetailApiImpl(dio: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepositoryImpl(movieDetailApi: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetMovieDetailUseCase>(
    () => GetMovieDetailUseCase(movieDetailRepository: getIt()),
  );

  // BLoC
  getIt.registerFactory<MovieDetailBloc>(
    () => MovieDetailBloc(getMovieDetailUseCase: getIt()),
  );
}

