import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/repositories/doctor_repository.dart';

class GetDoctorProfileUseCase {
  final DoctorRepository doctorRepository;
  GetDoctorProfileUseCase({required this.doctorRepository});

  Future<Either<Failures, DoctorProfileEntity>> call() =>
      doctorRepository.getDoctorProfile();
}

class UpdateDoctorProfileUseCase {
  final DoctorRepository doctorRepository;
  UpdateDoctorProfileUseCase({required this.doctorRepository});

  Future<Either<Failures, DoctorProfileEntity>> call({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath,
  }) =>
      doctorRepository.updateDoctorProfile(
        fullName: fullName,
        email: email,
        specialization: specialization,
        bio: bio,
        profilePicturePath: profilePicturePath,
      );
}

class GetAllDoctorsUseCase {
  final DoctorRepository doctorRepository;
  GetAllDoctorsUseCase({required this.doctorRepository});

  Future<Either<Failures, DoctorListEntity>> call() =>
      doctorRepository.getAllDoctors();
}

class GetDoctorPatientsUseCase {
  final DoctorRepository doctorRepository;
  GetDoctorPatientsUseCase({required this.doctorRepository});

  Future<Either<Failures, DoctorListEntity>> call() =>
      doctorRepository.getDoctorPatients();
}
