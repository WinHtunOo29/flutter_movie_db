import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/entities/movie_detail_entity.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(int movieId);
}

