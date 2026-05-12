import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/GetAllMoodResponseEntity.dart';
import '../../entities/MoodResponseEntity.dart';

abstract class MoodRepository {
  Future<Either<Failures, MoodResponseEntity>> selectMood(int moodType);
  Future<Either<Failures, GetAllMoodResponseEntity>> getAllMoods();
  Future<Either<Failures, MoodResponseEntity>> getMoodById(int id);
  Future<Either<Failures, MoodResponseEntity>> updateMood(int id, int moodType);
  Future<Either<Failures, MoodResponseEntity>> deleteMood(int id);
}
