import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';
import 'package:mindecho/features/auth/domain/use_cases/login_doctor_use_case.dart';
import 'package:mindecho/features/auth/domain/use_cases/login_user_use_case.dart';
import 'package:mindecho/features/auth/domain/use_cases/register_doctor_use_case.dart';
import 'package:mindecho/features/auth/domain/use_cases/register_user_use_case.dart';
import 'package:mindecho/core/errors/failures.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUserUseCase registerUserUseCase;
  final LoginUserUseCase loginUserUseCase;
  final RegisterDoctorUseCase registerDoctorUseCase;
  final LoginDoctorUseCase loginDoctorUseCase;

  AuthCubit({
    required this.registerUserUseCase,
    required this.loginUserUseCase,
    required this.registerDoctorUseCase,
    required this.loginDoctorUseCase,
  }) : super(AuthInitialState());

  Future<void> registerUser({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
  }) async {
    emit(AuthLoadingState());
    final result = await registerUserUseCase(
      fullName: fullName,
      email: email,
      password: password,
      gender: gender,
      age: age,
    );
    result.fold(
      (failure) => emit(AuthErrorState(failure: failure)),
      (auth) => emit(AuthSuccessState(authEntity: auth)),
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await loginUserUseCase(email: email, password: password);
    result.fold(
      (failure) => emit(AuthErrorState(failure: failure)),
      (auth) => emit(AuthSuccessState(authEntity: auth)),
    );
  }

  Future<void> registerDoctor({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
    required String licenseNumber,
    required String specialization,
    required String bio,
  }) async {
    emit(AuthLoadingState());
    final result = await registerDoctorUseCase(
      fullName: fullName,
      email: email,
      password: password,
      gender: gender,
      age: age,
      licenseNumber: licenseNumber,
      specialization: specialization,
      bio: bio,
    );
    result.fold(
      (failure) => emit(AuthErrorState(failure: failure)),
      (auth) => emit(AuthSuccessState(authEntity: auth)),
    );
  }

  Future<void> loginDoctor({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await loginDoctorUseCase(email: email, password: password);
    result.fold(
      (failure) => emit(AuthErrorState(failure: failure)),
      (auth) => emit(AuthSuccessState(authEntity: auth)),
    );
  }
}
