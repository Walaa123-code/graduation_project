import 'MoodDataEntity.dart';

class GetAllMoodResponseEntity {
  GetAllMoodResponseEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  List<MoodDataEntity>? data;
  dynamic errors;
}
