import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';
import 'package:flutter_movie_db/features/movie_list/domain/repositories/movie_list_repository.dart';

class GetUpcomingMovieListUseCase {
  final MovieListRepository movieListRepository;

  GetUpcomingMovieListUseCase({required this.movieListRepository});

  Future<Either<Failure, MovieListResponseEntity>> call() async {
    return movieListRepository.getUpcomingMovieList();
  }
}