import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';

abstract class MovieListRepository {
  Future<Either<Failure, MovieListResponseEntity>> getNowPlayingMovieList();
  Future<Either<Failure, MovieListResponseEntity>> getPopularMovieList();
  Future<Either<Failure, MovieListResponseEntity>> getTopRatedMovieList();
  Future<Either<Failure, MovieListResponseEntity>> getUpcomingMovieList();
}