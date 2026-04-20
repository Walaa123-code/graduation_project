part of 'profile_cubit.dart';

abstract class ProfileState {}

final class ProfileInitialState extends ProfileState {}
final class ProfileLoadingState extends ProfileState {}
final class ProfileSuccessState extends ProfileState {
 final ProfileResponseEntity profileResponseEntity;
  ProfileSuccessState ({required this.profileResponseEntity});
}
final class ProfileErrorState extends ProfileState {
 final Failures failures;
  ProfileErrorState({required this.failures});
}
