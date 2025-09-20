import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movie_db/core/auth/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<User?> call(String email, String password) async {
    return authRepository.register(email, password);
  }
}