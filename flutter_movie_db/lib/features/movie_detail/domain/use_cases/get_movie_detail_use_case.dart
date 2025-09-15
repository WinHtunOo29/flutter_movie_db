import 'package:dartz/dartz.dart';
import 'package:flutter_movie_db/core/error/failures.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/repositories/movie_detail_repository.dart';

class GetMovieDetailUseCase {
  final MovieDetailRepository movieDetailRepository;

  GetMovieDetailUseCase({required this.movieDetailRepository});

  Future<Either<Failure, MovieDetailEntity>> call(int movieId) async {
    return await movieDetailRepository.getMovieDetail(movieId);
  }
}

