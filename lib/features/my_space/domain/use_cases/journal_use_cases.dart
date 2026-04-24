import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/domain/entities/journal_entity.dart';
import 'package:mindecho/features/my_space/domain/repositories/journal_repository.dart';

class CreateJournalUseCase {
  final JournalRepository journalRepository;
  CreateJournalUseCase({required this.journalRepository});

  Future<Either<Failures, JournalEntity>> call({
    required String title,
    required String content,
    required String date,
  }) =>
      journalRepository.createJournal(
        title: title,
        content: content,
        date: date,
      );
}

class GetJournalsUseCase {
  final JournalRepository journalRepository;
  GetJournalsUseCase({required this.journalRepository});

  Future<Either<Failures, List<JournalEntity>>> call() =>
      journalRepository.getJournals();
}
