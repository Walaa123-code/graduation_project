import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalByIDResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/use_cases/journal_use_case.dart';
import 'package:meta/meta.dart';

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
