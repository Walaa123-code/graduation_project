import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/GetJournalByIDResEntity.dart';
import '../../domain/use_cases/journal_use_case.dart';

part 'update_journal_state.dart';

class UpdateJournalCubit extends Cubit<UpdateJournalState> {
  final JournalUseCase journalUseCase;
  UpdateJournalCubit(this.journalUseCase) : super(UpdateJournalInitialState());
  Future<void> updateJournal(int id, String title, String content,) async {
    emit(UpdateJournalLoadingState());

    var either = await journalUseCase.execute1(id, title, content);

    either.fold(
      (error) => emit(UpdateJournalErrorState(failures: error)),
      (response) => emit(UpdateJournalSuccessState(response: response)),
    );
  }
}

