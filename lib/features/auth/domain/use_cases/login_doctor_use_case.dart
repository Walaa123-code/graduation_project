import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';
import 'package:mindecho/features/auth/domain/repositories/auth_repository.dart';

class LoginDoctorUseCase {
  final AuthRepository authRepository;
  LoginDoctorUseCase({required this.authRepository});

  Future<Either<Failures, AuthEntity>> call({
    required String email,
    required String password,
  }) =>
      authRepository.loginDoctor(email: email, password: password);
}
