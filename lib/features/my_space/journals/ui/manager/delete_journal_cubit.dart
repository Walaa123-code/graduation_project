import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/DeleteJournalResEntity.dart';
import '../../domain/use_cases/journal_use_case.dart';

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
