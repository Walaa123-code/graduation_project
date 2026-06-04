import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';

abstract class DoctorRepository {
  /// GET /api/Doctor — fetch logged-in doctor's profile
  Future<Either<Failures, DoctorProfileEntity>> getDoctorProfile();

  /// POST /api/Doctor (multipart) — update doctor profile
  Future<Either<Failures, DoctorProfileEntity>> updateDoctorProfile({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath, // local file path (optional)
  });

  /// GET /api/Doctor/get-all-doctors — list all doctors
  Future<Either<Failures, DoctorListEntity>> getAllDoctors();

  /// GET /api/Doctor/patients — fetch doctor's patients
  Future<Either<Failures, DoctorListEntity>> getDoctorPatients();
}
