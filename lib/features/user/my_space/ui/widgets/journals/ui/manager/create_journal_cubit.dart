
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/GetJournalByIDResEntity.dart';
import '../../domain/use_cases/journal_use_case.dart';

part 'create_journal_state.dart';

class CreateJournalCubit extends Cubit<CreateJournalState> {
  final JournalUseCase journalUseCase;
  CreateJournalCubit(this.journalUseCase) : super(CreateJournalInitialState());
  Future<void> createJournal(String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      emit(CreateJournalErrorState(
          failures: ServerError(errors: "Title and Content cannot be empty")));
      return;
    }

    emit(CreateJournalLoadingState());
    var either = await journalUseCase.call(title, content);
    either.fold(
      (error) => emit(CreateJournalErrorState(failures: error)),
      (response) =>
          emit(CreateJournalSuccessState(createResponseEntity: response)),
    );
  }
}
