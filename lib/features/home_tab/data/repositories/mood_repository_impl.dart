import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/GetAllMoodResponseEntity.dart';
import '../../domain/entities/MoodResponseEntity.dart';
import '../../domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import '../../domain/repositories/repositories/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource moodRemoteDataSource;
  MoodRepositoryImpl({required this.moodRemoteDataSource});

  @override
  Future<Either<Failures, MoodResponseEntity>> selectMood(int moodType) async {
    var either = await moodRemoteDataSource.selectMood(moodType);
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, GetAllMoodResponseEntity>> getAllMoods() async {
    var either = await moodRemoteDataSource.getAllMoods();
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> getMoodById(int id) async {
    var either = await moodRemoteDataSource.getMoodById(id);
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> updateMood(int id, int moodType) async {
    var either = await moodRemoteDataSource.updateMood(id, moodType);
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> deleteMood(int id) async {
    var either = await moodRemoteDataSource.deleteMood(id);
    return either.fold((e) => left(e), (r) => right(r));
  }
}
