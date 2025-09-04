import 'package:dio/dio.dart';
import 'package:flutter_movie_db/core/constants/network_constants.dart';
import 'package:flutter_movie_db/core/error/exception_factory.dart';
import 'package:flutter_movie_db/features/movie_list/domain/entities/movie_list_response_entity.dart';

abstract class MovieListApi {
  Future<MovieListResponseEntity> getNowPlayingMovieList();
  Future<MovieListResponseEntity> getPopularMovieList();
  Future<MovieListResponseEntity> getTopRatedMovieList();
  Future<MovieListResponseEntity> getUpcomingMovieList();
}

class MovieListApiImpl extends MovieListApi {
  final Dio dio;

  MovieListApiImpl({required this.dio});

  @override
  Future<MovieListResponseEntity> getNowPlayingMovieList() async {
    final url = NetworkConstants.nowPlayingMoviesList;
    try {
      final response = await dio.get(url);
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }

  @override
  Future<MovieListResponseEntity> getPopularMovieList() async {
    final url = NetworkConstants.popularMoviesList;
    try {
      final response = await dio.get(url);
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }

  @override
  Future<MovieListResponseEntity> getTopRatedMovieList() async {
    final url = NetworkConstants.topRatedMoviesList;
    try {
      final response = await dio.get(url);
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }

  @override
  Future<MovieListResponseEntity> getUpcomingMovieList() async {
    final url = NetworkConstants.upcomingMoviesList;
    try {
      final response = await dio.get(url);
      return MovieListResponseEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }
}

