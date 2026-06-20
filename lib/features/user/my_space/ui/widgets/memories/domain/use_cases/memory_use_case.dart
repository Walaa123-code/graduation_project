import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../entities/DeleteMemoryResEntity.dart';
import '../entities/GetMemoryByIDResEntity.dart';
import '../entities/GetMemoryResponseEntity.dart';
import '../repositories/repositories/memory_repository.dart';

class MemoryUseCase {
  MemoryRepository memoryRepository;
  MemoryUseCase({required this.memoryRepository});
  Future<Either<Failures, GetMemoryResponseEntity>> invokeI() {
    return memoryRepository.getMemory();
  }

  Future<Either<Failures, GetMemoryByIdResEntity>> executeI(int id) {
    return memoryRepository.getMemoryById(id);
  }

  Future<Either<Failures, GetMemoryResponseEntity>> callI(
      String moodState, String title, String image) {
    return memoryRepository.createMemory(moodState, title, image);
  }

  Future<Either<Failures, GetMemoryResponseEntity>> executeII(
      int id, String title, String moodState, String image) {
    return memoryRepository.updateMemory(id, title, moodState, image);
  }

  Future<Either<Failures, DeleteMemoryResEntity>> invokeII(int id) {
    return memoryRepository.deleteMemory(id);
  }
}
