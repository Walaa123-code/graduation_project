import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/DeleteJournalResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalByIDResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalResponseEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/repositories/repositories/journal_repository.dart';

import '../../domain/repositories/data_source/remote_data_source/journal_data_source.dart';

class JournalRepositoryImpl implements JournalRepository {
  JournalDataSource journalDataSource;
  JournalRepositoryImpl({required this.journalDataSource});
  @override
  Future<Either<Failures, GetJournalResponseEntity>> getJournal() async {
    var either = await journalDataSource.getJournal();
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failures, GetJournalByIdResEntity>> getJournalsById(
      int id) async {
    var either = await journalDataSource.getJournalById(id);
    return either;
  }
  @override
  Future<Either<Failures, GetJournalByIdResEntity>> createJournal(
      String title, String content) async {
    var either = await journalDataSource.createJournal(title, content);
    return either;
  }

  @override
  Future<Either<Failures, GetJournalByIdResEntity>> updateJournal(
      int id, String title, String content) async {
    var either = await journalDataSource.updateJournal(id, title, content);
    return either;
  }

  @override
  Future<Either<Failures, DeleteJournalResEntity>> deleteJournal(
      int id) async {
    var either = await journalDataSource.deleteJournal(id);
    return either;
  }
}
