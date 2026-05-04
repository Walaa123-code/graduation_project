import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/my_space/journals/domain/use_cases/journal_use_case.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalByIDResEntity.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:meta/meta.dart';

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
