import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/user/profile_user/domain/entities/ProfileResponseEntity.dart';
import 'package:mindecho/features/user/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:mindecho/features/user/profile_user/domain/repositories/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Either<Failures, ProfileResponseEntity>> getProfile() async {
    var either = await profileRemoteDataSource.getProfile();
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
