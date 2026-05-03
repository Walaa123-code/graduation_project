import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/profile_user/domain/entities/ProfileResponseEntity.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failures, ProfileResponseEntity>> getProfile();
}
