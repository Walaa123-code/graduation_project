
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/GetJournalByIDResEntity.dart';
import '../../domain/use_cases/journal_use_case.dart';

part 'journal_details_state.dart';

class JournalDetailsCubit extends Cubit<JournalDetailsState> {
  final JournalUseCase journalUseCase;
  JournalDetailsCubit(this.journalUseCase)
      : super(JournalDetailsInitialState());

  Future<void> getJournalById(int id) async {
    emit(JournalDetailsLoadingState());
    var either = await journalUseCase.execute(id);
    either.fold(
      (error) => emit(JournalDetailsErrorState(failures: error)),
      (response) => emit(JournalDetailsSuccessState(getResponseEntity: response)),
    );

  }
}
