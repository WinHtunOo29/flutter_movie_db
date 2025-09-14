import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_now_playing_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_popular_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_top_rated_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_upcoming_movie_list_use_case.dart';

part 'movie_list.state.dart';
part 'movie_list_event.dart';

enum MovieListType {
  nowPlaying,
  popular,
  topRated,
  upcoming,
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovieListUseCase getNowPlayingMovieListUseCase;
  final GetPopularMovieListUseCase getPopularMovieListUseCase;
  final GetTopRatedMovieListUseCase getTopRatedMovieListUseCase;
  final GetUpcomingMovieListUseCase getUpcomingMovieListUseCase;

  MovieListBloc({
    required this.getNowPlayingMovieListUseCase,
    required this.getPopularMovieListUseCase,
    required this.getTopRatedMovieListUseCase,
    required this.getUpcomingMovieListUseCase,
  }) : super(MovieListInitial()) {
    on<LoadMovieListsEvent>(_onLoadMovieLists);
    on<RefreshMovieListsEvent>(_onRefreshMovieLists);
  }

  Future<void> _onLoadMovieLists(
    LoadMovieListsEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoading());
    
    try {
      final results = await Future.wait([
        getNowPlayingMovieListUseCase.call(),
        getPopularMovieListUseCase.call(),
        getTopRatedMovieListUseCase.call(),
        getUpcomingMovieListUseCase.call(),
      ]);

      for (int i = 0; i < results.length; i++) {
        final result = results[i];
        final useCaseName = ['NowPlaying', 'Popular', 'TopRated', 'Upcoming'][i];
        result.fold(
          (failure) {
            throw Exception('$useCaseName failed: ${failure.interpretation.message}');
          },
          (success) {
          },
        );
      }

      final nowPlaying = results[0].fold((l) => throw Exception(), (r) => r);
      final popular = results[1].fold((l) => throw Exception(), (r) => r);
      final topRated = results[2].fold((l) => throw Exception(), (r) => r);
      final upcoming = results[3].fold((l) => throw Exception(), (r) => r);

      emit(MovieListLoaded(
        getNowPlayingMovieListResponseEntity: nowPlaying,
        getPopularMovieListResponseEntity: popular,
        getTopRatedMovieListResponseEntity: topRated,
        getUpcomingMovieListResponseEntity: upcoming,
      ));
    } catch (e) {
      emit(MovieListError(message: e.toString()));
    }
  }

  Future<void> _onRefreshMovieLists(
    RefreshMovieListsEvent event,
    Emitter<MovieListState> emit,
  ) async {
    add(LoadMovieListsEvent());
  }
}