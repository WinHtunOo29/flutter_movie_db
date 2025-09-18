import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';
import 'package:flutter_movie_db/features/movie_list/domain/repositories/movie_list_repository.dart';

class GetPopularMovieListUseCase {
  final MovieListRepository movieListRepository;

  GetPopularMovieListUseCase({required this.movieListRepository});

  Future<Either<Failure, MovieListResponseEntity>> call({int page = 1}) async {
    return movieListRepository.getPopularMovieList(page: page);
  }
}