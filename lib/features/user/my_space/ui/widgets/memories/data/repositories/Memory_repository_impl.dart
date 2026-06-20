import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/DeleteMemoryResEntity.dart';
import '../../domain/entities/GetMemoryByIDResEntity.dart';
import '../../domain/entities/GetMemoryResponseEntity.dart';
import '../../domain/repositories/data_source/remote_data_source/memory_data_source.dart';
import '../../domain/repositories/repositories/memory_repository.dart';

class MemoryRepositoryImpl implements MemoryRepository {
  MemoryDataSource memoryDataSource;
  MemoryRepositoryImpl({required this.memoryDataSource});
  @override
  Future<Either<Failures, GetMemoryResponseEntity>> getMemory() async {
    var either = await memoryDataSource.getMemory();
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failures, GetMemoryByIdResEntity>> getMemoryById(int id) async {
    var either = await memoryDataSource.getMemoryById(id);
    return either;
  }

  @override
  Future<Either<Failures, GetMemoryResponseEntity>> createMemory(
      String title, String moodState, String image) async {
    var either = await memoryDataSource.createMemory(moodState, title, image);
    return either;
  }

  @override
  Future<Either<Failures, GetMemoryResponseEntity>> updateMemory(
      int id, String title, String moodState, String image) async {
    var either =
        await memoryDataSource.updateMemory(id, title, moodState, image);
    return either;
  }

  @override
  Future<Either<Failures, DeleteMemoryResEntity>> deleteMemory(int id) async {
    var either = await memoryDataSource.deleteMemory(id);
    return either;
  }
}
