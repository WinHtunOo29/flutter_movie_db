import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movie_db/core/auth/repositories/auth_repository.dart';
import 'package:flutter_movie_db/features/auth/data/data_sources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<User?> login(String email, String password) async {
    return authDataSource.login(email, password);
  }

  @override
  Future<User?> register(String email, String password) async {
    return authDataSource.register(email, password);
  }
}