import '../../domain/entities/GetAllBookingsResponseEntity.dart';
import 'BookingDataDM.dart';

class GetAllBookingsResponseDM extends GetAllBookingsResponseEntity {
  GetAllBookingsResponseDM({super.success, super.message, super.data, super.errors});

  factory GetAllBookingsResponseDM.fromJson(dynamic json) {
    return GetAllBookingsResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((v) => BookingDataDM.fromJson(v))
              .toList()
          : null,
      errors: json['errors'],
    );
  }
}
