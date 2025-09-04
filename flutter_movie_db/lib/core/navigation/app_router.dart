import 'package:flutter/cupertino.dart';
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
    routes: [
      ...MovieListRoutes.routes,
    ],
    redirect: (context, state) {
      return MovieListRoutes.all;
    },
  );
}