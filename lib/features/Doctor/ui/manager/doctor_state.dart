part of 'doctor_cubit.dart';

abstract class DoctorState {}

class DoctorInitialState extends DoctorState {}

class DoctorLoadingState extends DoctorState {}

class DoctorProfileLoadedState extends DoctorState {
  final DoctorProfileEntity profile;
  DoctorProfileLoadedState({required this.profile});
}

class DoctorProfileUpdatedState extends DoctorState {
  final DoctorProfileEntity profile;
  DoctorProfileUpdatedState({required this.profile});
}

class DoctorListLoadedState extends DoctorState {
  final DoctorListEntity doctorList;
  DoctorListLoadedState({required this.doctorList});
}

class DoctorErrorState extends DoctorState {
  final Failures failure;
  DoctorErrorState({required this.failure});
}
