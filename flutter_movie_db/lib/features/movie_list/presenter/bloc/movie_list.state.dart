part of 'movie_list_bloc.dart';

sealed class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final MovieListResponseEntity getNowPlayingMovieListResponseEntity;
  final MovieListResponseEntity getPopularMovieListResponseEntity;
  final MovieListResponseEntity getTopRatedMovieListResponseEntity;
  final MovieListResponseEntity getUpcomingMovieListResponseEntity;

  const MovieListLoaded({
    required this.getNowPlayingMovieListResponseEntity, 
    required this.getPopularMovieListResponseEntity, 
    required this.getTopRatedMovieListResponseEntity, 
    required this.getUpcomingMovieListResponseEntity,
  });

  @override
  List<Object?> get props => [getNowPlayingMovieListResponseEntity, getPopularMovieListResponseEntity, getTopRatedMovieListResponseEntity, getUpcomingMovieListResponseEntity];
}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError({required this.message});

  @override
  List<Object?> get props => [message];
}