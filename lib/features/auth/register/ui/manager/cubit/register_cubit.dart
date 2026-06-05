import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/register/domain/entities/register_response_entity.dart';
import 'package:mindecho/features/auth/register/domain/use_cases/register_use_case.dart';

part '../states/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterCubit({required this.registerUseCase}) : super(RegisterInitialState());

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoadingState());
    var either = await registerUseCase.invoke(name, email, password);
    either.fold(
      (error) => emit(RegisterErrorState(failures: error)),
      (response) async {
        if (response.data?.token != null) {
          await SharedPreferencesUtils.saveData(
            key: 'token',
            value: response.data!.token!,
          );
        }
        emit(RegisterSuccessState(registerResponseEntity: response));
      },
    );
  }
}
