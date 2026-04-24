import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/domain/entities/memory_entity.dart';
import 'package:mindecho/features/my_space/domain/repositories/memory_repository.dart';

class CreateMemoryUseCase {
  final MemoryRepository memoryRepository;
  CreateMemoryUseCase({required this.memoryRepository});

  Future<Either<Failures, MemoryEntity>> call({
    required int moodState,
    required String title,
    String? imagePath,
  }) =>
      memoryRepository.createMemory(
        moodState: moodState,
        title: title,
        imagePath: imagePath,
      );
}

class GetMemoriesUseCase {
  final MemoryRepository memoryRepository;
  GetMemoriesUseCase({required this.memoryRepository});

  Future<Either<Failures, List<MemoryEntity>>> call() =>
      memoryRepository.getMemories();
}
