import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/user/my_space/ui/widgets/memories/domain/use_cases/memory_use_case.dart';
import 'package:mindecho/features/user/my_space/ui/widgets/memories/ui/manager/delete_memory_state.dart';

class DeleteMemoryCubit extends Cubit<DeleteMemoryState> {
  final MemoryUseCase memoryUseCase;
  DeleteMemoryCubit(this.memoryUseCase) : super(DeleteMemoryInitialState());
  Future<void> deleteMemory(int id) async {
    emit(DeleteMemoryLoadingState());

    var either = await memoryUseCase.invokeII(id);

    either.fold(
      (error) => emit(DeleteMemoryErrorState(failures: error)),
      (response) =>
          emit(DeleteMemorySuccessState(deleteMemoryResEntity: response)),
    );
  }
}
