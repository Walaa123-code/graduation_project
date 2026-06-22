import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';

abstract class ScheduleRemoteDataSource {
  Future<Either<Failures, ScheduleEntity>> addSchedule({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
  });

  Future<Either<Failures, List<ScheduleEntity>>> getSchedules({
    required String doctorId,
  });

  Future<Either<Failures, bool>> deleteSchedule({required int id});
}
