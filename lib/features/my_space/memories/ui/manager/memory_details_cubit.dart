import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/GetMemoryByIDResEntity.dart';
import '../../domain/use_cases/memory_use_case.dart';

part 'memory_details_state.dart';

class MemoryDetailsCubit extends Cubit<MemoryDetailsState> {
  final MemoryUseCase memoryUseCase;
  MemoryDetailsCubit(this.memoryUseCase) : super(MemoryDetailsInitialState());

  Future<void> getMemoryById(int id) async {
    emit(MemoryDetailsLoadingState());
    var either = await memoryUseCase.executeI(id);
    either.fold(
      (error) => emit(MemoryDetailsErrorState(failures: error)),
      (response) =>
          emit(MemoryDetailsSuccessState(getMemoryDetResponseEntity: response)),
    );
  }
}
