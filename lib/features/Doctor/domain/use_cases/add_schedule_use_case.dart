import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/schedule_repository.dart';

class AddScheduleUseCase {
  final ScheduleRepository scheduleRepository;
  AddScheduleUseCase({required this.scheduleRepository});

  Future<Either<Failures, ScheduleEntity>> call({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
  }) =>
      scheduleRepository.addSchedule(
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
      );
}

class GetSchedulesUseCase {
  final ScheduleRepository scheduleRepository;
  GetSchedulesUseCase({required this.scheduleRepository});

  Future<Either<Failures, List<ScheduleEntity>>> call({required String doctorId}) =>
      scheduleRepository.getSchedules(doctorId: doctorId);
}
