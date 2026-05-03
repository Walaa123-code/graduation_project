import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/DeleteJournalResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalByIDResEntity.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../entities/GetJournalResponseEntity.dart';

abstract class JournalDataSource {
  Future<Either<Failures, GetJournalResponseEntity>> getJournal();
  Future<Either<Failures, GetJournalByIdResEntity>> getJournalById(int id);
  Future<Either<Failures, GetJournalByIdResEntity>> createJournal(
      String title, String content);
  Future<Either<Failures, GetJournalByIdResEntity>> updateJournal(
      int id, String title, String content);

  Future<Either<Failures, DeleteJournalResEntity>> deleteJournal(int id);
}
