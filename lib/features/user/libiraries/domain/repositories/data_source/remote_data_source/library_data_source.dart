import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../../entities/LibraryResponseEntity.dart';

abstract class LibraryDateSource {
  Future<Either<Failures, LibraryResponseEntity>> getLibrary(int mood);
}
