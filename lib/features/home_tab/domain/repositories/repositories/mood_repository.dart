import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/home_tab/domain/entities/MoodResponseEntity.dart';

abstract class MoodRepository {
  Future<Either<Failures, MoodResponseEntity>> selectMood(int id);
}
