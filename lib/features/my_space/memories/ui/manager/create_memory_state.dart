part of 'create_memory_cubit.dart';

sealed class CreateMemoryState {}

final class CreateMemoryInitialState extends CreateMemoryState {}

final class CreateMemorySuccessState extends CreateMemoryState {
  final GetMemoryResponseEntity createMemoryResponseEntity;
  CreateMemorySuccessState({required this.createMemoryResponseEntity});
}

final class CreateMemoryLoadingState extends CreateMemoryState {}

final class CreateMemoryErrorState extends CreateMemoryState {
  final Failures failures;
  CreateMemoryErrorState({required this.failures});
}
