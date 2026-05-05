part of 'delete_journal_cubit.dart';

sealed class DeleteJournalState {}

final class DeleteJournalInitialState extends DeleteJournalState {}

final class DeleteJournalSuccessState extends DeleteJournalState {
  final DeleteJournalResEntity deleteResponseEntity;
  DeleteJournalSuccessState({required this.deleteResponseEntity});
}


final class DeleteJournalLoadingState extends DeleteJournalState {}

final class DeleteJournalErrorState extends DeleteJournalState {
  final Failures failures;
  DeleteJournalErrorState({required this.failures});
}
