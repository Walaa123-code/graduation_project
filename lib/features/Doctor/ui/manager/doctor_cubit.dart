import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/use_cases/doctor_use_cases.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetDoctorProfileUseCase getDoctorProfileUseCase;
  final UpdateDoctorProfileUseCase updateDoctorProfileUseCase;
  final GetAllDoctorsUseCase getAllDoctorsUseCase;

  DoctorCubit({
    required this.getDoctorProfileUseCase,
    required this.updateDoctorProfileUseCase,
    required this.getAllDoctorsUseCase,
  }) : super(DoctorInitialState());

  Future<void> getDoctorProfile() async {
    emit(DoctorLoadingState());
    final result = await getDoctorProfileUseCase();
    result.fold(
      (failure) => emit(DoctorErrorState(failure: failure)),
      (profile) => emit(DoctorProfileLoadedState(profile: profile)),
    );
  }

  Future<void> updateDoctorProfile({
    required String fullName,
    required String email,
    required String specialization,
    required String bio,
    String? profilePicturePath,
  }) async {
    emit(DoctorLoadingState());
    final result = await updateDoctorProfileUseCase(
      fullName: fullName,
      email: email,
      specialization: specialization,
      bio: bio,
      profilePicturePath: profilePicturePath,
    );
    result.fold(
      (failure) => emit(DoctorErrorState(failure: failure)),
      (profile) => emit(DoctorProfileUpdatedState(profile: profile)),
    );
  }

  Future<void> getAllDoctors() async {
    emit(DoctorLoadingState());
    final result = await getAllDoctorsUseCase();
    result.fold(
      (failure) => emit(DoctorErrorState(failure: failure)),
      (list) => emit(DoctorListLoadedState(doctorList: list)),
    );
  }
}
