import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/data/models/schedule_dm.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/data_source/remote_data_source/schedule_remote_data_source.dart';

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final ApiManager apiManager;

  ScheduleRemoteDataSourceImpl({required this.apiManager});

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
      final response = await apiManager.postData(
        endPoint: EndPoints.addDoctorSchedule,
        body: {
          'dayOfWeek': dayOfWeek,
          'startTime': startTime,
          'endTime': endTime,
        },
        options: Options(contentType: 'application/json'),
      );
      final data = (response.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>? ??
          {};
      return Right(ScheduleDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ScheduleEntity>>> getSchedules({
    required String doctorId,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response = await apiManager.getData(
        endPoint: EndPoints.getDoctorSchedules,
        queryParameters: {'DoctorId': doctorId},
      );
      final data = response.data as Map<String, dynamic>;
      final list = (data['data'] as List<dynamic>? ?? [])
          .map((e) => ScheduleDM.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> deleteSchedule({required int id}) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final endpoint = EndPoints.deleteDoctorSchedule.replaceAll('{id}', id.toString());
      final response = await apiManager.deleteData(endPoint: endpoint);
      // Depending on the API, it might return true or some success indicator.
      return const Right(true);
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }
}
