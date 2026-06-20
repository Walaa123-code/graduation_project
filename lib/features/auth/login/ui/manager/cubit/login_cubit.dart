// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
// import 'package:mindecho/core/errors/failures.dart';
// import 'package:mindecho/features/auth/login/domain/entities/login_response_entity.dart';
// import 'package:mindecho/features/auth/login/domain/use_cases/login_use_case.dart';
//
// part '../states/login_state.dart';
//
// class LoginCubit extends Cubit<LoginState> {
//   final LoginUseCase loginUseCase;
//   LoginCubit({required this.loginUseCase}) : super(LoginInitialState());
//
//   Future<void> login(String email, String password) async {
//     emit(LoginLoadingState());
//     var either = await loginUseCase.invoke(email, password);
//     either.fold(
//       (error) => emit(LoginErrorState(failures: error)),
//       (response) async {
//         if (response.data?.token != null) {
//           await SharedPreferencesUtils.saveData(
//             key: 'token',
//             value: response.data!.token!,
//           );
//         }
//         emit(LoginSuccessState(loginResponseEntity: response));
//       },
//     );
//   }
// }
