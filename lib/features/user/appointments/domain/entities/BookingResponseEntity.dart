import 'BookingDataEntity.dart';

class BookingResponseEntity {
  BookingResponseEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  BookingDataEntity? data;
  dynamic errors;
}
