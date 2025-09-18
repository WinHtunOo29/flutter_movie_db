part of 'paginated_movie_list_bloc.dart';

abstract class PaginatedMovieListEvent extends Equatable {
  const PaginatedMovieListEvent();

  @override
  List<Object?> get props => [];
}

class LoadPaginatedMovieListEvent extends PaginatedMovieListEvent {
  final MovieListType movieListType;
  final int page;

  const LoadPaginatedMovieListEvent({
    required this.movieListType,
    required this.page,
  });

  @override
  List<Object?> get props => [movieListType, page];
}
