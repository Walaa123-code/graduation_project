import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/domain/entities/journal_entity.dart';

abstract class JournalRepository {
  Future<Either<Failures, JournalEntity>> createJournal({
    required String title,
    required String content,
    required String date,
  });

  Future<Either<Failures, List<JournalEntity>>> getJournals();
}
