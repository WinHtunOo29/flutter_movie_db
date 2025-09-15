import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_db/features/movie_detail/routes.dart';
import 'package:flutter_movie_db/features/movie_list/routes.dart';
import 'package:go_router/go_router.dart';

class AppNavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get context => navigatorKey.currentContext;
}

class AppRouter {
  final GoRouter router;
  
  AppRouter() : router = GoRouter(
    navigatorKey: AppNavigatorKey.navigatorKey,
    initialLocation: MovieListRoutes.all,
    routes: [
      ...MovieListRoutes.routes,
      ...MovieDetailRoutes.routes,
    ],
  );
}