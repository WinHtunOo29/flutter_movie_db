import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_db/core/auth/bloc/auth_bloc.dart';
import 'package:flutter_movie_db/core/navigation/router_refresh_listenable.dart';
import 'package:flutter_movie_db/features/auth/routes.dart';
import 'package:flutter_movie_db/features/movie_detail/routes.dart';
import 'package:flutter_movie_db/features/movie_list/routes.dart';
import 'package:go_router/go_router.dart';

class AppNavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get context => navigatorKey.currentContext;
}

class AppRouter {
  final GoRouter router;
  
  AppRouter(AuthBloc authBloc) : router = GoRouter(
    navigatorKey: AppNavigatorKey.navigatorKey,
    initialLocation: AuthRoutes.login,
    routes: [
      ...AuthRoutes.routes,
      ...MovieListRoutes.routes,
      ...MovieDetailRoutes.routes,
    ],
    redirect: (context, state) {
      final isLoggedIn = authBloc.state is LoginSuccess;
      final isOnAuthRoute = state.fullPath == AuthRoutes.login || state.fullPath == AuthRoutes.register;
      
      if (isLoggedIn && isOnAuthRoute) {
        return MovieListRoutes.all;
      }
      
      if (!isLoggedIn && !isOnAuthRoute) {
        return AuthRoutes.login;
      }

      return null;
    },
    refreshListenable: RouterRefreshListenable(authBloc.stream),
  );
}