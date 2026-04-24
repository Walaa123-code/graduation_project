import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';

/// Data model that parses the server response:
/// { "success": true, "data": { "token": "...", "doctorId": null }, "errors": null }
class AuthResponseDM extends AuthEntity {
  AuthResponseDM({required super.token, super.doctorId});

  factory AuthResponseDM.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return AuthResponseDM(
      token: data['token'] as String? ?? '',
      doctorId: data['doctorId'] as String?,
    );
  }
}
