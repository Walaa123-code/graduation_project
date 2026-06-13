import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/data/models/doctor_dm.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/data_source/remote_data_source/doctor_remote_data_source.dart';

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final ApiManager apiManager;

  DoctorRemoteDataSourceImpl({required this.apiManager});

  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  Future<Either<Failures, DoctorProfileEntity>> getDoctorProfile() async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response =
          await apiManager.getData(endPoint: EndPoints.getDoctorProfile);
      final data = (response.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>? ??
          {};
      return Right(DoctorProfileDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, DoctorProfileEntity>> updateDoctorProfile({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final fields = <String, dynamic>{
        'FullName': fullName,
        'Email': email,
        'Specialization': specialization,
        'Bio': bio,
      };
      if (profilePicturePath != null) {
        fields['ProfilePicture'] = await MultipartFile.fromFile(
          profilePicturePath,
          filename: profilePicturePath.split('/').last,
        );
      }
      final formData = FormData.fromMap(fields);
      final response = await apiManager.postFormData(
        endPoint: EndPoints.updateDoctorProfile,
        formData: formData,
      );
      final data = (response.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>? ??
          {};
      return Right(DoctorProfileDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, DoctorListEntity>> getAllDoctors() async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response =
          await apiManager.getData(endPoint: EndPoints.getAllDoctors);
      return Right(
          DoctorListDM.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, DoctorListEntity>> getDoctorPatients() async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response =
          await apiManager.getData(endPoint: EndPoints.getDoctorPatients);
      final data = response.data as Map<String, dynamic>;
      final list = (data['data'] as List<dynamic>? ?? [])
          .map((e) => DoctorProfileDM.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(DoctorListEntity(doctors: list, totalCount: list.length));
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map) {
        final mapData = e.response!.data as Map<String, dynamic>;
        final msg = mapData['message']?.toString() ?? '';
        if (msg.toLowerCase().contains('no patients found')) {
          return const Right(DoctorListEntity(doctors: [], totalCount: 0));
        }
        return Left(ServerError(errors: msg.isNotEmpty ? msg : e.toString()));
      }
      return Left(ServerError(errors: e.toString()));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }
}
