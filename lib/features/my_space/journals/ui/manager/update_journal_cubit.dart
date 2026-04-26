import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/my_space/journals/domain/use_cases/journal_use_case.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/GetJournalByIDResEntity.dart';

part 'update_journal_state.dart';

class UpdateJournalCubit extends Cubit<UpdateJournalState> {
  final JournalUseCase journalUseCase;
  UpdateJournalCubit(this.journalUseCase) : super(UpdateJournalInitialState());
  Future<void> updateJournal(int id, String title, String content) async {
    emit(UpdateJournalLoadingState());

    var either = await journalUseCase.execute1(id, title, content);

    either.fold(
      (error) => emit(UpdateJournalErrorState(failures: error)),
      (response) => emit(UpdateJournalSuccessState(response: response)),
    );
  }
}
