import 'BookingDataEntity.dart';

class GetAllBookingsResponseEntity {
  GetAllBookingsResponseEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  List<BookingDataEntity>? data;
  dynamic errors;
}
