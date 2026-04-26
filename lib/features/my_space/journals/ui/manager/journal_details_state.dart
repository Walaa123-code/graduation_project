part of 'journal_details_cubit.dart';

@immutable
sealed class JournalDetailsState {}

final class JournalDetailsInitialState extends JournalDetailsState {}
final class JournalDetailsLoadingState extends JournalDetailsState {}
final class JournalDetailsSuccessState extends JournalDetailsState {
  final GetJournalByIdResEntity getResponseEntity;
  JournalDetailsSuccessState({required this.getResponseEntity});
}
final class JournalDetailsErrorState extends JournalDetailsState {
  final Failures failures;
  JournalDetailsErrorState({required this.failures});
}