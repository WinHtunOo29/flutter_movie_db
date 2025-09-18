import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/features/movie_detail/presenter/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie_db/features/movie_detail/presenter/pages/movie_detail_page.dart';
import 'package:go_router/go_router.dart';

class MovieDetailRoutes {
  static const String movieDetailPattern = '/movie-detail/:id';
  static String movieDetail(String id) => '/movie-detail/$id';

  static final List<GoRoute> routes = [
    GoRoute(
      path: movieDetailPattern,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return BlocProvider<MovieDetailBloc>(
          create: (context) => getIt<MovieDetailBloc>(),
          child: MovieDetailPage(movieId: id),
        );
      },
    ),
  ];

  static void navigateToMovieDetail(BuildContext context, String id) {
    context.push(movieDetail(id));
  }
}
