import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/DeleteJournalResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/use_cases/journal_use_case.dart';
import 'package:graduation_project/features/my_space/journals/ui/manager/update_journal_cubit.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failures.dart';

part 'delete_journal_state.dart';

class DeleteJournalCubit extends Cubit<DeleteJournalState> {
  final JournalUseCase journalUseCase;
  DeleteJournalCubit(this.journalUseCase) : super(DeleteJournalInitialState());
  Future<void> deleteJournal(int id) async {
    emit(DeleteJournalLoadingState());

    var either = await journalUseCase.invoke1(id);

    either.fold(
      (error) => emit(DeleteJournalErrorState(failures: error)),
      (response) =>
          emit(DeleteJournalSuccessState(deleteResponseEntity: response)),
    );
  }
}
