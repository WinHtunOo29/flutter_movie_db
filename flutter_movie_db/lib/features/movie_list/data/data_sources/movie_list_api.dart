import 'package:dio/dio.dart';
import 'package:flutter_movie_db/core/constants/network_constants.dart';
import 'package:flutter_movie_db/core/error/exception_factory.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';

abstract class MovieListApi {
  Future<MovieListResponseEntity> getNowPlayingMovieList({int page = 1});
  Future<MovieListResponseEntity> getPopularMovieList({int page = 1});
  Future<MovieListResponseEntity> getTopRatedMovieList({int page = 1});
  Future<MovieListResponseEntity> getUpcomingMovieList({int page = 1});
}

class MovieListApiImpl extends MovieListApi {
  final Dio dio;

  MovieListApiImpl({required this.dio});

  @override
  Future<MovieListResponseEntity> getNowPlayingMovieList({int page = 1}) async {
    final url = NetworkConstants.nowPlayingMoviesList;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'page': page,
        },
      );
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }

  @override
  Future<MovieListResponseEntity> getPopularMovieList({int page = 1}) async {
    final url = NetworkConstants.popularMoviesList;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'page': page,
        },
      );
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }

  @override
  Future<MovieListResponseEntity> getTopRatedMovieList({int page = 1}) async {
    final url = NetworkConstants.topRatedMoviesList;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'page': page,
        },
      );
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }

  @override
  Future<MovieListResponseEntity> getUpcomingMovieList({int page = 1}) async {
    final url = NetworkConstants.upcomingMoviesList;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'page': page,
        },
      );

      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }
}

