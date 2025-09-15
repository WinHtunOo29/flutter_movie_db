import 'package:dio/dio.dart';
import 'package:flutter_movie_db/core/constants/network_constants.dart';
import 'package:flutter_movie_db/core/error/exception_factory.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/entities/movie_detail_entity.dart';

abstract class MovieDetailApi {
  Future<MovieDetailEntity> getMovieDetail(int movieId);
}

class MovieDetailApiImpl extends MovieDetailApi {
  final Dio dio;

  MovieDetailApiImpl({required this.dio});

  @override
  Future<MovieDetailEntity> getMovieDetail(int movieId) async {
    final url = '${NetworkConstants.movieDetail}/$movieId';
    try {
      final response = await dio.get(url);
      return MovieDetailEntity.fromJson(response.data);
    } on DioException catch (e, s) {
      throw AppExceptionFactory.fromException(e, s);
    }
  }
}

