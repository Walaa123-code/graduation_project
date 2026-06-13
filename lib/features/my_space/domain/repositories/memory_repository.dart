import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/domain/entities/memory_entity.dart';

abstract class MemoryRepository {
  Future<Either<Failures, MemoryEntity>> createMemory({
    required int moodState,
    required String title,
    String? imagePath, // Path to local file
  });

  Future<Either<Failures, List<MemoryEntity>>> getMemories();
}
