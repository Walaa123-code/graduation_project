import 'package:dartz/dartz.dart';
import 'package:mindecho/features/my_space/memories/domain/entities/DeleteMemoryResEntity.dart';
import '../../../../../../core/errors/failures.dart';
import '../../entities/GetMemoryByIDResEntity.dart';
import '../../entities/GetMemoryResponseEntity.dart';

abstract class MemoryRepository {
  Future<Either<Failures, GetMemoryResponseEntity>> getMemory();
  Future<Either<Failures, GetMemoryByIdResEntity>> getMemoryById(int id);
  Future<Either<Failures, GetMemoryResponseEntity>> createMemory(
      String moodState, String title, String image);
  Future<Either<Failures, GetMemoryResponseEntity>> updateMemory(
      int id, String title, String moodState, String image);

  Future<Either<Failures, DeleteMemoryResEntity>> deleteMemory(int id);
}
