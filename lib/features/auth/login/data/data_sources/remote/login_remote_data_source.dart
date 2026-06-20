import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../../domain/entities/login_response_entity.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password);
}
