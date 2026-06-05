import '../../domain/entities/register_response_entity.dart';

class RegisterResponseDM extends RegisterResponseEntity {
  RegisterResponseDM({super.success, super.message, super.data, super.errors});

  factory RegisterResponseDM.fromJson(dynamic json) {
    return RegisterResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? RegisterDataDM.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class RegisterDataDM extends RegisterDataEntity {
  RegisterDataDM({super.token, super.doctorId});

  factory RegisterDataDM.fromJson(Map<String, dynamic> json) {
    return RegisterDataDM(
      token: json['token'],
      doctorId: json['doctorId'],
    );
  }
}
