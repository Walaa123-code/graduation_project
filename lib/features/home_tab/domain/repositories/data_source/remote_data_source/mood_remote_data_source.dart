import 'package:dartz/dartz.dart';
import 'package:mindecho/features/home_tab/domain/entities/MoodResponseEntity.dart';

import '../../../../../../core/errors/failures.dart';

abstract class MoodRemoteDataSource {
  Future<Either<Failures, MoodResponseEntity>> selectMood(int id);
}
