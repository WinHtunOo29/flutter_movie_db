import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/exception_factory.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_detail/data/data_sources/movie_detail_api.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/repositories/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailApi movieDetailApi;

  MovieDetailRepositoryImpl({required this.movieDetailApi});

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(int movieId) async {
    try {
      final result = await movieDetailApi.getMovieDetail(movieId);
      return Right(result);
    } catch (e,s) {
      final appException = AppExceptionFactory.fromException(e, s);
      return Left(Failure(exception: appException));
    }
  }
}

