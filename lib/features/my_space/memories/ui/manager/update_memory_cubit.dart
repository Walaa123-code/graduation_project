import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/my_space/memories/ui/manager/update_memory_state.dart';
import '../../domain/use_cases/memory_use_case.dart';

class UpdateMemoryCubit extends Cubit<UpdateMemoryState> {
  final MemoryUseCase memoryUseCase;
  UpdateMemoryCubit(this.memoryUseCase) : super(UpdateMemoryInitialState());
  Future<void> updateMemory(
      int id, String title, String moodState, String image) async {
    emit(UpdateMemoryLoadingState());

    var either = await memoryUseCase.executeII(id, title, moodState, image);

    either.fold(
      (error) => emit(UpdateMemoryErrorState(failures: error)),
      (response) => emit(UpdateMemorySuccessState(response: response)),
    );
  }
}
