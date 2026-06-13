/// Domain entity for auth response data: { token, doctorId }
class AuthEntity {
  final String token;
  final String? doctorId;

  const AuthEntity({required this.token, this.doctorId});
}
