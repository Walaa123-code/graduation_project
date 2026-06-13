import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/data_source/remote_data_source/schedule_remote_data_source.dart';
import 'package:mindecho/features/Doctor/domain/repositories/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, ScheduleEntity>> addSchedule({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
  }) async {
    return await remoteDataSource.addSchedule(
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  Future<Either<Failures, List<ScheduleEntity>>> getSchedules({required String doctorId}) async {
    return await remoteDataSource.getSchedules(doctorId: doctorId);
  }
}
