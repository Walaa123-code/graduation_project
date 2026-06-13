import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/data_source/remote_data_source/doctor_remote_data_source.dart';
import 'package:mindecho/features/Doctor/domain/repositories/repository/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, DoctorProfileEntity>> getDoctorProfile() async {
    return await remoteDataSource.getDoctorProfile();
  }

  @override
  Future<Either<Failures, DoctorProfileEntity>> updateDoctorProfile({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath,
  }) async {
    return await remoteDataSource.updateDoctorProfile(
      fullName: fullName,
      email: email,
      specialization: specialization,
      bio: bio,
      profilePicturePath: profilePicturePath,
    );
  }

  @override
  Future<Either<Failures, DoctorListEntity>> getAllDoctors() async {
    return await remoteDataSource.getAllDoctors();
  }

  @override
  Future<Either<Failures, DoctorListEntity>> getDoctorPatients() async {
    return await remoteDataSource.getDoctorPatients();
  }
}
