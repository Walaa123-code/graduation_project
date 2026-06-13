import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/domain/entities/journal_entity.dart';
import 'package:mindecho/features/my_space/domain/use_cases/journal_use_cases.dart';

part 'journal_state.dart';

class JournalCubit extends Cubit<JournalState> {
  final CreateJournalUseCase createJournalUseCase;
  final GetJournalsUseCase getJournalsUseCase;

  JournalCubit({
    required this.createJournalUseCase,
    required this.getJournalsUseCase,
  }) : super(JournalInitialState());

  Future<void> createJournal({
    required String title,
    required String content,
    required String date,
  }) async {
    emit(JournalLoadingState());
    final result = await createJournalUseCase(
      title: title,
      content: content,
      date: date,
    );
    result.fold(
      (failure) => emit(JournalErrorState(failure: failure)),
      (journal) => emit(JournalCreatedState(journal: journal)),
    );
  }

  Future<void> getJournals() async {
    emit(JournalLoadingState());
    final result = await getJournalsUseCase();
    result.fold(
      (failure) => emit(JournalErrorState(failure: failure)),
      (journals) => emit(JournalsLoadedState(journals: journals)),
    );
  }
}
