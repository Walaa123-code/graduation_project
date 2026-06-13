part of 'journal_cubit.dart';

abstract class JournalState {}

class JournalInitialState extends JournalState {}

class JournalLoadingState extends JournalState {}

class JournalCreatedState extends JournalState {
  final JournalEntity journal;
  JournalCreatedState({required this.journal});
}

class JournalsLoadedState extends JournalState {
  final List<JournalEntity> journals;
  JournalsLoadedState({required this.journals});
}

class JournalErrorState extends JournalState {
  final Failures failure;
  JournalErrorState({required this.failure});
}
