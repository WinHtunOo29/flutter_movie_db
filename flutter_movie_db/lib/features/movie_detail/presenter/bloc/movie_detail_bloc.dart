import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_db/features/movie_detail/domain/use_cases/get_movie_detail_use_case.dart';

part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUseCase getMovieDetailUseCase;

  MovieDetailBloc({
    required this.getMovieDetailUseCase,
  }) : super(MovieDetailInitial()) {
    on<LoadMovieDetailEvent>(_onLoadMovieDetail);
  }

  Future<void> _onLoadMovieDetail(
    LoadMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    
    try {
      final result = await getMovieDetailUseCase.call(event.movieId);
      
      result.fold(
        (failure) {
          emit(MovieDetailError(message: failure.interpretation.message));
        },
        (movieDetail) {
          emit(MovieDetailLoaded(movieDetail: movieDetail));
        },
      );
    } catch (e) {
      emit(MovieDetailError(message: e.toString()));
    }
  }
}

