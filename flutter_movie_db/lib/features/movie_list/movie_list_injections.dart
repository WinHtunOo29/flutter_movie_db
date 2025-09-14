import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/features/movie_list/data/data_sources/movie_list_api.dart';
import 'package:flutter_movie_db/features/movie_list/data/repositories/movie_list_repository_impl.dart';
import 'package:flutter_movie_db/features/movie_list/domain/repositories/movie_list_repository.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_now_playing_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_popular_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_top_rated_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_upcoming_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/movie_list_bloc.dart';

void movieListInjections() {
  // Data Sources
  getIt.registerLazySingleton<MovieListApi>(
    () => MovieListApiImpl(dio: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<MovieListRepository>(
    () => MovieListRepositoryImpl(movieListApi: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetNowPlayingMovieListUseCase>(
    () => GetNowPlayingMovieListUseCase(movieListRepository: getIt()),
  );

  getIt.registerLazySingleton<GetPopularMovieListUseCase>(
    () => GetPopularMovieListUseCase(movieListRepository: getIt()),
  );

  getIt.registerLazySingleton<GetTopRatedMovieListUseCase>(
    () => GetTopRatedMovieListUseCase(movieListRepository: getIt()),
  );

  getIt.registerLazySingleton<GetUpcomingMovieListUseCase>(
    () => GetUpcomingMovieListUseCase(movieListRepository: getIt()),
  );

  // BLoC
  getIt.registerFactory<MovieListBloc>(
    () => MovieListBloc(
      getNowPlayingMovieListUseCase: getIt(),
      getPopularMovieListUseCase: getIt(),
      getTopRatedMovieListUseCase: getIt(),
      getUpcomingMovieListUseCase: getIt(),
    ),
  );
}