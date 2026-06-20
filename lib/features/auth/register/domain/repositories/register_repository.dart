import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../entities/register_response_entity.dart';
abstract class RegisterRepository {
  Future<Either<Failures, RegisterResponseEntity>> register(
      String name,
      String email,
      String password,
      int age,
      String gender,
      );
}