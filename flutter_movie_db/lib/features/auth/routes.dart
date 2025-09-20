import 'package:flutter_movie_db/features/auth/presenter/pages/login_page.dart';
import 'package:flutter_movie_db/features/auth/presenter/pages/register_page.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static const String login = '/login';
  static const String register = '/register';

  static List<GoRoute> get routes => [
    GoRoute(
      path: login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: register,
      builder: (context, state) => const RegisterPage(),
    ),
  ];
}