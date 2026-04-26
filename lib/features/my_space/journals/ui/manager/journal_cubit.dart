import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalResponseEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/use_cases/journal_use_case.dart';

import '../../domain/entities/GetJournalByIDResEntity.dart';

part 'journal_state.dart';

class JournalCubit extends Cubit<JournalState> {
  final JournalUseCase journalUseCase;
  JournalCubit(this.journalUseCase) : super(GetJournalInitialState());

  Future<void> getJournal() async {
    emit(GetJournalLoadingState());
    var either = await journalUseCase.invoke();
    either.fold(
          (error) => emit(GetJournalErrorState(failures: error)),
          (response) => emit(GetJournalSuccessState(getJournalResponseEntity: response)),
    );
  }
}