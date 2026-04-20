part of 'mood_cubit.dart';

@immutable
sealed class MoodState {}

final class MoodInitialState extends MoodState {}

final class MoodLoadingState extends MoodState {}

final class MoodSuccessState extends MoodState {
  final MoodResponseEntity moodResponseEntity;
  MoodSuccessState({required this.moodResponseEntity});
}

final class MoodErrorState extends MoodState {
  final Failures failures;
  MoodErrorState({required this.failures});
}
