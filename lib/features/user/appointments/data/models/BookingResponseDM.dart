import '../../domain/entities/BookingResponseEntity.dart';
import 'BookingDataDM.dart';

class BookingResponseDM extends BookingResponseEntity {
  BookingResponseDM({super.success, super.message, super.data, super.errors});

  factory BookingResponseDM.fromJson(dynamic json) {
    return BookingResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? BookingDataDM.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}
