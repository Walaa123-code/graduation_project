part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final AuthEntity authEntity;
  AuthSuccessState({required this.authEntity});
}

class AuthErrorState extends AuthState {
  final Failures failure;
  AuthErrorState({required this.failure});
}
