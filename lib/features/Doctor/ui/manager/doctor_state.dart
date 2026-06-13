part of 'doctor_cubit.dart';

class DoctorState {
  final DoctorProfileEntity? profile;
  final DoctorListEntity? patients;
  final DoctorListEntity? allDoctors;
  final bool isLoading;
  final Failures? error;

  DoctorState({
    this.profile,
    this.patients,
    this.allDoctors,
    this.isLoading = false,
    this.error,
  });

  DoctorState copyWith({
    DoctorProfileEntity? profile,
    DoctorListEntity? patients,
    DoctorListEntity? allDoctors,
    bool? isLoading,
    Failures? error,
    bool clearError = false,
  }) {
    return DoctorState(
      profile: profile ?? this.profile,
      patients: patients ?? this.patients,
      allDoctors: allDoctors ?? this.allDoctors,
      isLoading: isLoading ?? false, // Default to false if not specified during copy
      error: clearError ? null : (error ?? this.error),
    );
  }
}
