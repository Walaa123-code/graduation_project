import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/DeleteJournalResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalByIDResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalResponseEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/repositories/repositories/journal_repository.dart';

class JournalUseCase {
  JournalRepository journalRepository;
  JournalUseCase({required this.journalRepository});
  Future<Either<Failures, GetJournalResponseEntity>> invoke() {
    return journalRepository.getJournal();
  }

  Future<Either<Failures, GetJournalByIdResEntity>> execute(int id) {
    return journalRepository.getJournalsById(id);
  }
  Future<Either<Failures, GetJournalByIdResEntity>> call(
      String title, String content) {
    return journalRepository.createJournal(title, content);
  }

  Future<Either<Failures, GetJournalByIdResEntity>> execute1(
      int id, String title, String content) {
    return journalRepository.updateJournal(id, title, content);
  }

  Future<Either<Failures, DeleteJournalResEntity>> invoke1(int id) {
    return journalRepository.deleteJournal(id);
  }
}
