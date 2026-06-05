import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/login_response_entity.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  Future<Either<Failures, LoginResponseEntity>> invoke(
          String email, String password) =>
      loginRepository.login(email, password);
}
