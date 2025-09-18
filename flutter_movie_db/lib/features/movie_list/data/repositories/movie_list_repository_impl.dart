import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/exception_factory.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_list/data/data_sources/movie_list_api.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';
import 'package:flutter_movie_db/features/movie_list/domain/repositories/movie_list_repository.dart';

class MovieListRepositoryImpl extends MovieListRepository {
  final MovieListApi movieListApi;

  MovieListRepositoryImpl({required this.movieListApi});

  @override
  Future<Either<Failure, MovieListResponseEntity>> getNowPlayingMovieList({int page = 1}) async {
    try {
      final response = await movieListApi.getNowPlayingMovieList(page: page);
      return Right(response);
    } catch (e,s) {
      final appException = AppExceptionFactory.fromException(e, s);
      return Left(Failure(exception: appException));
    }
  }

  @override
  Future<Either<Failure, MovieListResponseEntity>> getPopularMovieList({int page = 1}) async {
    try {
      final response = await movieListApi.getPopularMovieList(page: page);
      return Right(response);
    } catch (e,s) {
      final appException = AppExceptionFactory.fromException(e, s);
      return Left(Failure(exception: appException));
    }
  }

  @override
  Future<Either<Failure, MovieListResponseEntity>> getTopRatedMovieList({int page = 1}) async {
    try {
      final response = await movieListApi.getTopRatedMovieList(page: page);
      return Right(response);
    } catch (e,s) {
      final appException = AppExceptionFactory.fromException(e, s);
      return Left(Failure(exception: appException));
    }
  }

  @override
  Future<Either<Failure, MovieListResponseEntity>> getUpcomingMovieList({int page = 1}) async {
    try {
      final response = await movieListApi.getUpcomingMovieList(page: page);
      return Right(response);
    } catch (e,s) {
      final appException = AppExceptionFactory.fromException(e, s);
      return Left(Failure(exception: appException));
    }
  }
}