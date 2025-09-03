import 'package:flutter_movie_db/features/movies/presenter/pages/movies_page.dart';
import 'package:go_router/go_router.dart';

class MoviesRoutes {
  static const String all = '/movies';
  static const String nowPlaying = '/movies/now-playing';
  static const String popular = '/movies/popular';
  static const String topRated = '/movies/top-rated';
  static const String upcoming = '/movies/upcoming';

  static final List<GoRoute> routes = [
    GoRoute(
      path: all, 
      builder: (context, state) => const MoviesPage(),
    ),
  ];
}