import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movie_db/core/auth/bloc/auth_bloc.dart';
import 'package:flutter_movie_db/core/di/injector.dart';

class AuthSession {
  static final AuthSession _singleton = AuthSession._internal();
  final AuthBloc _authBloc = getIt<AuthBloc>();

  factory AuthSession() {
    return _singleton;
  }

  AuthSession._internal();

  User? get currentUser => (_authBloc.state as LoginSuccess).user;

  bool get isLoggedIn => currentUser != null;

  String? get currentUserEmail => currentUser?.email;
}