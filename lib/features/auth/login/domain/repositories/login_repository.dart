import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../entities/login_response_entity.dart';

abstract class LoginRepository {
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password);
}
