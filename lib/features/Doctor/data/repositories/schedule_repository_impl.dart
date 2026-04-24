import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/data/models/schedule_dm.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ApiManager apiManager;
  ScheduleRepositoryImpl({required this.apiManager});

  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  Future<Either<Failures, ScheduleEntity>> addSchedule({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final formData = FormData.fromMap({
        'DayOfWeek': dayOfWeek.toString(),
        'StartTime': startTime,
        'EndTime': endTime,
      });
      final response = await apiManager.postFormData(
        endPoint: EndPoints.addDoctorSchedule,
        formData: formData,
      );
      final data = (response.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>? ??
          {};
      return Right(ScheduleDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }
}
