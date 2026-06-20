import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../../domain/entities/register_response_entity.dart';
abstract class RegisterRemoteDataSource {
  Future<Either<Failures, RegisterResponseEntity>> register(
      String name,
      String email,
      String password,
      int age,
      String gender,
      );
}