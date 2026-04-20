import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/home_tab/domain/entities/MoodResponseEntity.dart';
import 'package:graduation_project/features/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import 'package:graduation_project/features/home_tab/domain/repositories/repositories/mood_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MoodRepository)
class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource moodRemoteDataSource;
  MoodRepositoryImpl({required this.moodRemoteDataSource});
  @override
  Future<Either<Failures, MoodResponseEntity>> selectMood(int id) async {
    var either = await moodRemoteDataSource.selectMood(id);
    return either.fold((error) => left(error), (response) => right(response));
  }
}
