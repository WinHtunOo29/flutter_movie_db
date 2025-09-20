import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/core/auth/use_cases/login_use_case.dart';
import 'package:flutter_movie_db/core/auth/use_cases/register_use_case.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      final result = await loginUseCase.call(event.email, event.password);
      if (result != null) {
        emit(LoginSuccess(user: result));
      } else {
        emit(LoginError(error: 'Login failed'));
      }
    } catch (e) {
      emit(LoginError(error: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(RegisterLoading());
    try {
      final result = await registerUseCase.call(event.email, event.password);
      if (result != null) {
        emit(RegisterSuccess(user: result));
      } else {
        emit(RegisterError(error: 'Register failed'));
      }
    } catch (e) {
      emit(RegisterError(error: e.toString().replaceFirst('Exception: ', '')));
    }
  }
}