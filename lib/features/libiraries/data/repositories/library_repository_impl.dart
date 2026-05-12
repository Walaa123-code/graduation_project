import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/libiraries/domain/entities/LibraryResponseEntity.dart';
import 'package:mindecho/features/libiraries/domain/repositories/data_source/remote_data_source/library_data_source.dart';
import 'package:mindecho/features/libiraries/domain/repositories/repository/library_rebository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryDateSource libraryDateSource;
  LibraryRepositoryImpl({required this.libraryDateSource});

  @override
  Future<Either<Failures, LibraryResponseEntity>> getLibrary(int mood) async {
    var either = await libraryDateSource.getLibrary(mood);
    return either.fold((e) => left(e), (r) => right(r));
  }
}
