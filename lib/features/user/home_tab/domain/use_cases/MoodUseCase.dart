import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../entities/GetAllMoodResponseEntity.dart';
import '../entities/MoodResponseEntity.dart';
import '../repositories/repositories/mood_repository.dart';

class MoodUseCase {
  final MoodRepository moodRepository;
  MoodUseCase({required this.moodRepository});

  // Create mood
  Future<Either<Failures, MoodResponseEntity>> invoke(int moodType) =>
      moodRepository.selectMood(moodType);

  // Get all moods
  Future<Either<Failures, GetAllMoodResponseEntity>> call() =>
      moodRepository.getAllMoods();

  // Get mood by id
  Future<Either<Failures, MoodResponseEntity>> execute(int id) =>
      moodRepository.getMoodById(id);

  // Update mood
  Future<Either<Failures, MoodResponseEntity>> invoke1(int id, int moodType) =>
      moodRepository.updateMood(id, moodType);

  // Delete mood
  Future<Either<Failures, MoodResponseEntity>> call1(int id) =>
      moodRepository.deleteMood(id);
}
