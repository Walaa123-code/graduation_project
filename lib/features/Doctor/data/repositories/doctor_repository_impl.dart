import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/data/models/doctor_dm.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final ApiManager apiManager;

  DoctorRepositoryImpl({required this.apiManager});

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
}
