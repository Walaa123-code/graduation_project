part of '../cubit/register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}
final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  final RegisterResponseEntity registerResponseEntity;
  RegisterSuccessState({required this.registerResponseEntity});
}

final class RegisterErrorState extends RegisterState {
  final Failures failures;
  RegisterErrorState({required this.failures});
}
