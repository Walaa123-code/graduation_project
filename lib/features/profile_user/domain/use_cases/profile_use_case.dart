import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/profile_user/domain/repositories/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/ProfileResponseEntity.dart';
@injectable
class ProfileUseCase {
  final ProfileRepository profileRepository;
  ProfileUseCase({required this.profileRepository});
  Future<Either<Failures, ProfileResponseEntity>> invoke() {
    return profileRepository.getProfile();
  }
}
