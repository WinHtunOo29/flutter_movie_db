import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_now_playing_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_popular_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_top_rated_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/domain/use_cases/get_upcoming_movie_list_use_case.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/movie_list_bloc.dart';

part 'paginated_movie_list.state.dart';
part 'paginated_movie_list_event.dart';

class PaginatedMovieListBloc extends Bloc<PaginatedMovieListEvent, PaginatedMovieListState> {
  final GetNowPlayingMovieListUseCase getNowPlayingMovieListUseCase;
  final GetPopularMovieListUseCase getPopularMovieListUseCase;
  final GetTopRatedMovieListUseCase getTopRatedMovieListUseCase;
  final GetUpcomingMovieListUseCase getUpcomingMovieListUseCase;

  PaginatedMovieListBloc({
    required this.getNowPlayingMovieListUseCase,
    required this.getPopularMovieListUseCase,
    required this.getTopRatedMovieListUseCase,
    required this.getUpcomingMovieListUseCase,
  }) : super(PaginatedMovieListInitial()) {
    on<LoadPaginatedMovieListEvent>(_onLoadPaginatedMovieList);
  }

  Future<void> _onLoadPaginatedMovieList(
    LoadPaginatedMovieListEvent event,
    Emitter<PaginatedMovieListState> emit,
  ) async {
    try {
      if (event.page == 1) {
        emit(PaginatedMovieListLoading());
      }

      final useCase = _getUseCaseForType(event.movieListType);
      final result = await useCase.call(page: event.page);

      result.fold(
        (failure) {
          emit(PaginatedMovieListError(message: failure.interpretation.message));
        },
        (success) {
          final currentState = state;
          
          List<MovieEntity> movies;
          if (currentState is PaginatedMovieListLoaded && event.page > 1) {
            movies = [...currentState.movies, ...success.results];
          } else {
            movies = success.results;
          }

          emit(PaginatedMovieListLoaded(
            movies: movies,
            currentPage: success.page,
            totalPages: success.totalPages,
            hasReachedMax: success.page >= success.totalPages,
          ));
        },
      );
    } catch (e) {
      emit(PaginatedMovieListError(message: e.toString()));
    }
  }

  dynamic _getUseCaseForType(MovieListType type) {
    return switch (type) {
      MovieListType.nowPlaying => getNowPlayingMovieListUseCase,
      MovieListType.popular => getPopularMovieListUseCase,
      MovieListType.topRated => getTopRatedMovieListUseCase,
      MovieListType.upcoming => getUpcomingMovieListUseCase,
    };
  }
}
