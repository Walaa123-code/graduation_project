part of 'journal_details_cubit.dart';

sealed class JournalDetailsState {}

final class JournalDetailsInitialState extends JournalDetailsState {}
final class JournalDetailsLoadingState extends JournalDetailsState {}
final class JournalDetailsSuccessState extends JournalDetailsState {
  final GetJournalByIdResEntity getResponseDetEntity;
  JournalDetailsSuccessState({required this.getResponseDetEntity});
}
final class JournalDetailsErrorState extends JournalDetailsState {
  final Failures failures;
  JournalDetailsErrorState({required this.failures});
}
