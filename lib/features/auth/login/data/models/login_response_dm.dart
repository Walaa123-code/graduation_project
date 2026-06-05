import '../../domain/entities/login_response_entity.dart';

class LoginResponseDM extends LoginResponseEntity {
  LoginResponseDM({super.success, super.message, super.data, super.errors});

  factory LoginResponseDM.fromJson(dynamic json) {
    return LoginResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? LoginDataDM.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class LoginDataDM extends LoginDataEntity {
  LoginDataDM({super.token, super.doctorId});

  factory LoginDataDM.fromJson(Map<String, dynamic> json) {
    return LoginDataDM(
      token: json['token'],
      doctorId: json['doctorId'],
    );
  }
}
