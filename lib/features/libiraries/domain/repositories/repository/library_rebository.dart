import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/LibraryResponseEntity.dart';

abstract class LibraryRepository {
  Future<Either<Failures, LibraryResponseEntity>> getLibrary(int mood);
}
