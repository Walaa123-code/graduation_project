import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';

abstract class DoctorRemoteDataSource {
  Future<Either<Failures, DoctorProfileEntity>> getDoctorProfile();
  
  Future<Either<Failures, DoctorProfileEntity>> updateDoctorProfile({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath,
  });

  Future<Either<Failures, DoctorListEntity>> getAllDoctors();

  Future<Either<Failures, DoctorListEntity>> getDoctorPatients();
}
