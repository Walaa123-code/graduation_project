import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';
import 'package:mindecho/features/auth/domain/repositories/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository authRepository;
  LoginUserUseCase({required this.authRepository});

  Future<Either<Failures, AuthEntity>> call({
    required String email,
    required String password,
  }) =>
      authRepository.loginUser(email: email, password: password);
}
