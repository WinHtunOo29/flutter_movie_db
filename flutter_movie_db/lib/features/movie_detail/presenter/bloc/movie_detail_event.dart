part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieDetailEvent extends MovieDetailEvent {
  final int movieId;

  const LoadMovieDetailEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

