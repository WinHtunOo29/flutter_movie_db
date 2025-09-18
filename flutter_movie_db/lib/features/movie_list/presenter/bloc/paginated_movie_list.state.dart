part of 'paginated_movie_list_bloc.dart';

sealed class PaginatedMovieListState extends Equatable {
  const PaginatedMovieListState();

  @override
  List<Object?> get props => [];
}

class PaginatedMovieListInitial extends PaginatedMovieListState {}

class PaginatedMovieListLoading extends PaginatedMovieListState {}

class PaginatedMovieListLoaded extends PaginatedMovieListState {
  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;

  const PaginatedMovieListLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [movies, currentPage, totalPages, hasReachedMax];
}

class PaginatedMovieListError extends PaginatedMovieListState {
  final String message;

  const PaginatedMovieListError({required this.message});

  @override
  List<Object?> get props => [message];
}
