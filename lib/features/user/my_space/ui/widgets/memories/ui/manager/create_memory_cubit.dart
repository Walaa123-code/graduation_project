import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/GetMemoryResponseEntity.dart';
import '../../domain/use_cases/memory_use_case.dart';

part 'create_memory_state.dart';

class CreateMemoryCubit extends Cubit<CreateMemoryState> {
  final MemoryUseCase memoryUseCase;
  CreateMemoryCubit(this.memoryUseCase) : super(CreateMemoryInitialState());

  Future<void> createMemory(
      String moodState, String title, String image) async {
    if (title.isEmpty || image.isEmpty) {
      emit(CreateMemoryErrorState(
          failures: ServerError(errors: "Title and Image cannot be empty")));
      return;
    }

    emit(CreateMemoryLoadingState());
    var either = await memoryUseCase.callI(moodState, title, image);
    either.fold(
      (error) => emit(CreateMemoryErrorState(failures: error)),
      (response) =>
          emit(CreateMemorySuccessState(createMemoryResponseEntity: response)),
    );
  }
}
