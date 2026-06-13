part of 'memory_cubit.dart';

abstract class MemoryState {}

class MemoryInitialState extends MemoryState {}

class MemoryLoadingState extends MemoryState {}

class MemoryCreatedState extends MemoryState {
  final MemoryEntity memory;
  MemoryCreatedState({required this.memory});
}

class MemoriesLoadedState extends MemoryState {
  final List<MemoryEntity> memories;
  MemoriesLoadedState({required this.memories});
}

class MemoryErrorState extends MemoryState {
  final Failures failure;
  MemoryErrorState({required this.failure});
}
