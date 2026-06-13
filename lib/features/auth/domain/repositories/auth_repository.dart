import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, AuthEntity>> registerUser({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
  });

  Future<Either<Failures, AuthEntity>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failures, AuthEntity>> registerDoctor({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
    required String licenseNumber,
    required String specialization,
    required String bio,
  });

  Future<Either<Failures, AuthEntity>> loginDoctor({
    required String email,
    required String password,
  });
}
