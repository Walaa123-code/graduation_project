part of 'memory_details_cubit.dart';

sealed class MemoryDetailsState {}

final class MemoryDetailsInitialState extends MemoryDetailsState {}

final class MemoryDetailsLoadingState extends MemoryDetailsState {}

final class MemoryDetailsSuccessState extends MemoryDetailsState {
  final GetMemoryByIdResEntity getMemoryDetResponseEntity;
  MemoryDetailsSuccessState({required this.getMemoryDetResponseEntity});
}

final class MemoryDetailsErrorState extends MemoryDetailsState {
  final Failures failures;
  MemoryDetailsErrorState({required this.failures});
}
