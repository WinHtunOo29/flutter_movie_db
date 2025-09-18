import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/movie_list_bloc.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/paginated_movie_list_bloc.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/pages/movie_list_page.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/pages/paginated_movie_list_page.dart';
import 'package:go_router/go_router.dart';

class MovieListRoutes {
  static const String all = '/movies';
  static const String nowPlaying = '/movies/now-playing';
  static const String popular = '/movies/popular';
  static const String topRated = '/movies/top-rated';
  static const String upcoming = '/movies/upcoming';

  static final List<GoRoute> routes = [
    GoRoute(
      path: all, 
      builder: (context, state) => const MovieListPage(),
    ),
    GoRoute(
      path: nowPlaying,
      builder: (context, state) {
        final extra = state.extra as MovieListType;
        return BlocProvider<PaginatedMovieListBloc>(
          create: (context) => getIt<PaginatedMovieListBloc>(),
          child: PaginatedMovieListPage(movieListType: extra),
        );
      }
    ),
    GoRoute(
      path: popular,
      builder: (context, state) {
        final extra = state.extra as MovieListType;
        return BlocProvider<PaginatedMovieListBloc>(
          create: (context) => getIt<PaginatedMovieListBloc>(),
          child: PaginatedMovieListPage(movieListType: extra),
        );
      },
    ),
    GoRoute(
      path: topRated,
      builder: (context, state) {
        final extra = state.extra as MovieListType;
        return BlocProvider<PaginatedMovieListBloc>(
          create: (context) => getIt<PaginatedMovieListBloc>(),
          child: PaginatedMovieListPage(movieListType: extra),
        );
      },
    ),
    GoRoute(
      path: upcoming,
      builder: (context, state) {
        final extra = state.extra as MovieListType;
        return BlocProvider<PaginatedMovieListBloc>(
          create: (context) => getIt<PaginatedMovieListBloc>(),
          child: PaginatedMovieListPage(movieListType: extra),
        );
      },
    ),
  ];
}