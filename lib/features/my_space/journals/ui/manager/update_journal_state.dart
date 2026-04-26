part of 'update_journal_cubit.dart';

@immutable
sealed class UpdateJournalState {}

final class UpdateJournalInitialState extends UpdateJournalState {}

final class UpdateJournalLoadingState extends UpdateJournalState {}

final class UpdateJournalSuccessState extends UpdateJournalState {
  final GetJournalByIdResEntity response;
  UpdateJournalSuccessState({required this.response});
}

final class UpdateJournalErrorState extends UpdateJournalState {
  final Failures failures;
  UpdateJournalErrorState({required this.failures});
}
