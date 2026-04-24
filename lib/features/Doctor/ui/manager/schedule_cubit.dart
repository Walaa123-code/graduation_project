import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/domain/use_cases/add_schedule_use_case.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final AddScheduleUseCase addScheduleUseCase;

  ScheduleCubit({required this.addScheduleUseCase})
      : super(ScheduleInitialState());

  Future<void> addSchedule({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
  }) async {
    emit(ScheduleLoadingState());
    final result = await addScheduleUseCase(
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
    );
    result.fold(
      (failure) => emit(ScheduleErrorState(failure: failure)),
      (schedule) => emit(ScheduleAddedState(schedule: schedule)),
    );
  }
}
