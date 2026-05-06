import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/memory_use_case.dart';
import 'memory_state.dart';

class MemoryCubit extends Cubit<MemoryState> {
  final MemoryUseCase memoryUseCase;
  MemoryCubit(this.memoryUseCase) : super(GetMemoryInitialState());

  Future<void> getMemory() async {
    emit(GetMemoryLoadingState());
    var either = await memoryUseCase.invokeI();
    either.fold(
      (error) => emit(GetMemoryErrorState(failures: error)),
      (response) =>
          emit(GetMemorySuccessState(getMemoryResponseEntity: response)),
    );
  }
}
