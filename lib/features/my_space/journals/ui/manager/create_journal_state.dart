part of 'create_journal_cubit.dart';

@immutable
sealed class CreateJournalState {}

final class CreateJournalInitialState extends CreateJournalState {}

final class CreateJournalSuccessState extends CreateJournalState {
 final GetJournalByIdResEntity createResponseEntity;
 CreateJournalSuccessState({ required this.createResponseEntity});
}


final class CreateJournalLoadingState extends CreateJournalState {}

final class CreateJournalErrorState extends CreateJournalState {
  final Failures failures;
  CreateJournalErrorState({required this.failures});
}

