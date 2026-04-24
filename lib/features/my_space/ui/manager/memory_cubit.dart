import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/domain/entities/memory_entity.dart';
import 'package:mindecho/features/my_space/domain/use_cases/memory_use_cases.dart';

part 'memory_state.dart';

class MemoryCubit extends Cubit<MemoryState> {
  final CreateMemoryUseCase createMemoryUseCase;
  final GetMemoriesUseCase getMemoriesUseCase;

  MemoryCubit({
    required this.createMemoryUseCase,
    required this.getMemoriesUseCase,
  }) : super(MemoryInitialState());

  Future<void> createMemory({
    required int moodState,
    required String title,
    String? imagePath,
  }) async {
    emit(MemoryLoadingState());
    final result = await createMemoryUseCase(
      moodState: moodState,
      title: title,
      imagePath: imagePath,
    );
    result.fold(
      (failure) => emit(MemoryErrorState(failure: failure)),
      (memory) => emit(MemoryCreatedState(memory: memory)),
    );
  }

  Future<void> getMemories() async {
    emit(MemoryLoadingState());
    final result = await getMemoriesUseCase();
    result.fold(
      (failure) => emit(MemoryErrorState(failure: failure)),
      (memories) => emit(MemoriesLoadedState(memories: memories)),
    );
  }
}
