part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginError extends AuthState {
  final String error;

  const LoginError({required this.error});

  @override
  List<Object?> get props => [error];
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final User user;

  const RegisterSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class RegisterError extends AuthState {
  final String error;

  const RegisterError({required this.error});

  @override
  List<Object?> get props => [error];
}