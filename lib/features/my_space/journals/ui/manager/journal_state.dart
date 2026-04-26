part of 'journal_cubit.dart';

@immutable
sealed class JournalState {}

final class GetJournalInitialState extends JournalState {}

final class GetJournalSuccessState extends JournalState {
  final GetJournalResponseEntity getJournalResponseEntity;
  GetJournalSuccessState({required this.getJournalResponseEntity});
}

final class GetJournalLoadingState extends JournalState {}

final class GetJournalErrorState extends JournalState {
  final Failures failures;
  GetJournalErrorState({required this.failures});
}
// get JournalId
final class GetJournalByIdSuccessState extends JournalState {
  final GetJournalByIdResEntity getJournalByIdResponseEntity;
  GetJournalByIdSuccessState({required this.getJournalByIdResponseEntity});
}
final class GetJournalByIdLoadingState extends JournalState {}
