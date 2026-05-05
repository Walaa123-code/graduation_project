import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/DeleteJournalResEntity.dart';
import '../../domain/entities/GetMemoryByIDResEntity.dart';
import '../../domain/entities/GetMemoryResponseEntity.dart';
import '../../domain/repositories/data_source/remote_data_source/memory_data_source.dart';
import '../../domain/repositories/repositories/memory_repository.dart';

class JournalRepositoryImpl implements MemoryRepository {
  MemoryDataSource journalDataSource;
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
