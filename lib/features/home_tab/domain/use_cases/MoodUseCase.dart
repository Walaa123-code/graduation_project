import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/home_tab/domain/entities/MoodResponseEntity.dart';
import 'package:graduation_project/features/home_tab/domain/repositories/repositories/mood_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoodUseCase {
  final MoodRepository moodRepository;
  MoodUseCase({required this.moodRepository});
  Future<Either<Failures, MoodResponseEntity>> invoke(int id) {
    return moodRepository.selectMood(id);
  }
}
