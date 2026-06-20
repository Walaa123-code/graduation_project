import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/GetJournalByIDResEntity.dart';
import '../../domain/entities/GetJournalResponseEntity.dart';
import '../../domain/use_cases/journal_use_case.dart';

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
