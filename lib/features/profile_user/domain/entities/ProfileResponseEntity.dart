class ProfileResponseEntity {
  ProfileResponseEntity({
      this.success, 
      this.message, 
      this.data, 
      this.errors,});

  bool? success;
  String? message;
  DataEntity? data;
  dynamic errors;


}

class ErrorsEntity {
  ErrorsEntity({
      this.key0, 
      this.key1,});

  List<String>? key0;
  List<String>? key1;


}

class DataEntity {
  DataEntity({
      this.id, 
      this.fullName, 
      this.email, 
      this.gender, 
      this.age, 
      this.profilePicture,});

  String? id;
  String? fullName;
  String? email;
  int? gender;
  int? age;
  String? profilePicture;


}