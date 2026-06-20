import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../entities/LibraryResponseEntity.dart';
import '../repositories/repository/library_rebository.dart';

class LibraryUseCase {
  final LibraryRepository libraryRepository;
  LibraryUseCase({required this.libraryRepository});

  Future<Either<Failures, LibraryResponseEntity>> invoke(int mood) =>
      libraryRepository.getLibrary(mood);
}
