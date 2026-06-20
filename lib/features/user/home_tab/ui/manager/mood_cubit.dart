import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/GetAllMoodResponseEntity.dart';
import '../../domain/entities/MoodResponseEntity.dart';
import '../../domain/use_cases/MoodUseCase.dart';

part 'mood_state.dart';

class MoodCubit extends Cubit<MoodState> {
  final MoodUseCase moodUseCase;
  MoodCubit({required this.moodUseCase}) : super(MoodInitialState());

  Future<void> selectMood(int moodType) async {
    emit(MoodLoadingState());
    var either = await moodUseCase.invoke(moodType);
    either.fold(
      (error) => emit(MoodErrorState(failures: error)),
      (response) => emit(MoodSuccessState(moodResponseEntity: response)),
    );
  }

  Future<void> getAllMoods() async {
    emit(GetAllMoodsLoadingState());
    var either = await moodUseCase.call();
    either.fold(
      (error) => emit(GetAllMoodsErrorState(failures: error)),
      (response) =>
          emit(GetAllMoodsSuccessState(getAllMoodResponseEntity: response)),
    );
  }

  Future<void> getMoodById(int id) async {
    emit(GetMoodByIdLoadingState());
    var either = await moodUseCase.execute(id);
    either.fold(
      (error) => emit(GetMoodByIdErrorState(failures: error)),
      (response) => emit(GetMoodByIdSuccessState(moodResponseEntity: response)),
    );
  }

  Future<void> updateMood(int id, int moodType) async {
    emit(UpdateMoodLoadingState());
    var either = await moodUseCase.invoke1(id, moodType);
    either.fold(
      (error) => emit(UpdateMoodErrorState(failures: error)),
      (response) => emit(UpdateMoodSuccessState(moodResponseEntity: response)),
    );
  }

  Future<void> deleteMood(int id) async {
    emit(DeleteMoodLoadingState());
    var either = await moodUseCase.call1(id);
    either.fold(
      (error) => emit(DeleteMoodErrorState(failures: error)),
      (response) => emit(DeleteMoodSuccessState(moodResponseEntity: response)),
    );
  }
}
