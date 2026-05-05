import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/DeleteJournalResEntity.dart';
import '../../entities/GetJournalByIDResEntity.dart';
import '../../entities/GetJournalResponseEntity.dart';

abstract class JournalRepository {
  Future<Either<Failures, GetJournalResponseEntity>> getJournal();
  Future<Either<Failures, GetJournalByIdResEntity>> getJournalsById(int id);
  Future<Either<Failures, GetJournalByIdResEntity>> createJournal(
      String title, String content);
  Future<Either<Failures, GetJournalByIdResEntity>> updateJournal(
      int id, String title, String content);

  Future<Either<Failures, DeleteJournalResEntity>> deleteJournal(int id);
}
