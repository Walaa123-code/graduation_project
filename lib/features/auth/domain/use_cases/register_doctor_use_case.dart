import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';
import 'package:mindecho/features/auth/domain/repositories/auth_repository.dart';

class RegisterDoctorUseCase {
  final AuthRepository authRepository;
  RegisterDoctorUseCase({required this.authRepository});

  Future<Either<Failures, AuthEntity>> call({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
    required String licenseNumber,
    required String specialization,
    required String bio,
  }) =>
      authRepository.registerDoctor(
        fullName: fullName,
        email: email,
        password: password,
        gender: gender,
        age: age,
        licenseNumber: licenseNumber,
        specialization: specialization,
        bio: bio,
      );
}
