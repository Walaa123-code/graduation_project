part of 'mood_cubit.dart';

@immutable
sealed class MoodState {}

final class MoodInitialState extends MoodState {}

// Select Mood
final class MoodLoadingState extends MoodState {}
final class MoodSuccessState extends MoodState {
  final MoodResponseEntity moodResponseEntity;
  MoodSuccessState({required this.moodResponseEntity});
}
final class MoodErrorState extends MoodState {
  final Failures failures;
  MoodErrorState({required this.failures});
}

// Get All Moods
final class GetAllMoodsLoadingState extends MoodState {}
final class GetAllMoodsSuccessState extends MoodState {
  final GetAllMoodResponseEntity getAllMoodResponseEntity;
  GetAllMoodsSuccessState({required this.getAllMoodResponseEntity});
}
final class GetAllMoodsErrorState extends MoodState {
  final Failures failures;
  GetAllMoodsErrorState({required this.failures});
}

// Get Mood By Id
final class GetMoodByIdLoadingState extends MoodState {}
final class GetMoodByIdSuccessState extends MoodState {
  final MoodResponseEntity moodResponseEntity;
  GetMoodByIdSuccessState({required this.moodResponseEntity});
}
final class GetMoodByIdErrorState extends MoodState {
  final Failures failures;
  GetMoodByIdErrorState({required this.failures});
}

// Update Mood
final class UpdateMoodLoadingState extends MoodState {}
final class UpdateMoodSuccessState extends MoodState {
  final MoodResponseEntity moodResponseEntity;
  UpdateMoodSuccessState({required this.moodResponseEntity});
}
final class UpdateMoodErrorState extends MoodState {
  final Failures failures;
  UpdateMoodErrorState({required this.failures});
}

// Delete Mood
final class DeleteMoodLoadingState extends MoodState {}
final class DeleteMoodSuccessState extends MoodState {
  final MoodResponseEntity moodResponseEntity;
  DeleteMoodSuccessState({required this.moodResponseEntity});
}
final class DeleteMoodErrorState extends MoodState {
  final Failures failures;
  DeleteMoodErrorState({required this.failures});
}
