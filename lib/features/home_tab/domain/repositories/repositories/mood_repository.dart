import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/home_tab/domain/entities/MoodResponseEntity.dart';

abstract class MoodRepository {
  Future<Either<Failures, MoodResponseEntity>> selectMood(int id);
}
