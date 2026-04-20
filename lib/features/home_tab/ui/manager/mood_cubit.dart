import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/home_tab/domain/entities/MoodResponseEntity.dart';
import 'package:graduation_project/features/home_tab/domain/use_cases/MoodUseCase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';

part 'mood_state.dart';
@injectable
class MoodCubit extends Cubit<MoodState> {
  final MoodUseCase moodUseCase;

  MoodCubit({required this.moodUseCase}) : super(MoodInitialState());
  Future<void> selectMood(int id) async {
    emit(MoodLoadingState());
    var either = await moodUseCase.invoke(id);
    either.fold((error) {
      emit(MoodErrorState(failures: error));
    }, (response) {
      emit(MoodSuccessState(moodResponseEntity: response));
    });
  }
}
