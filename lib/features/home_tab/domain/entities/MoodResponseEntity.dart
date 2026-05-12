import 'MoodDataEntity.dart';

class MoodResponseEntity {
  MoodResponseEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  MoodDataEntity? data;
  dynamic errors;
}
