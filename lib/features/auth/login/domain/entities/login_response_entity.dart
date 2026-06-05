class LoginResponseEntity {
  LoginResponseEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  LoginDataEntity? data;
  dynamic errors;
}

class LoginDataEntity {
  LoginDataEntity({this.token, this.doctorId});

  String? token;
  String? doctorId;
}
