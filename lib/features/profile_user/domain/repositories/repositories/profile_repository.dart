import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/profile_user/domain/entities/ProfileResponseEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failures, ProfileResponseEntity>> getProfile();
}
