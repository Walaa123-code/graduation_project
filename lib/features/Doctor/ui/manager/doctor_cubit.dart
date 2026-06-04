import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/use_cases/doctor_use_cases.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetDoctorProfileUseCase getDoctorProfileUseCase;
  final UpdateDoctorProfileUseCase updateDoctorProfileUseCase;
  final GetAllDoctorsUseCase getAllDoctorsUseCase;
  final GetDoctorPatientsUseCase getDoctorPatientsUseCase;

  DoctorCubit({
    required this.getDoctorProfileUseCase,
    required this.updateDoctorProfileUseCase,
    required this.getAllDoctorsUseCase,
    required this.getDoctorPatientsUseCase,
  }) : super(DoctorState());

  Future<void> getDoctorProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await getDoctorProfileUseCase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (profile) => emit(state.copyWith(isLoading: false, profile: profile)),
    );
  }

  Future<void> updateDoctorProfile({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await updateDoctorProfileUseCase(
      fullName: fullName,
      email: email,
      specialization: specialization,
      bio: bio,
      profilePicturePath: profilePicturePath,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (profile) => emit(state.copyWith(isLoading: false, profile: profile)),
    );
  }

  Future<void> getAllDoctors() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await getAllDoctorsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (list) => emit(state.copyWith(isLoading: false, allDoctors: list)),
    );
  }

  Future<void> getDoctorPatients() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await getDoctorPatientsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (patients) => emit(state.copyWith(isLoading: false, patients: patients)),
    );
  }
}
