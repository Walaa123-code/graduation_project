class RegisterResponseEntity {
  RegisterResponseEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  RegisterDataEntity? data;
  dynamic errors;
}

class RegisterDataEntity {
  RegisterDataEntity({this.token, this.doctorId});

  String? token;
  String? doctorId;
}
