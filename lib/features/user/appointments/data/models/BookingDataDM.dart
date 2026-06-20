import '../../domain/entities/BookingDataEntity.dart';

class BookingDataDM extends BookingDataEntity {
  BookingDataDM({
    super.id,
    super.doctorSessionSlotId,
    super.userId,
    super.doctorId,
    super.bookingStatus,
    super.requestedAt,
    super.confirmedAt,
  });

  factory BookingDataDM.fromJson(Map<String, dynamic> json) {
    return BookingDataDM(
      id: json['id'],
      doctorSessionSlotId: json['doctorSessionSlotId'],
      userId: json['userId'],
      doctorId: json['doctorId'],
      bookingStatus: json['bookingStatus'],
      requestedAt: json['requestedAt'],
      confirmedAt: json['confirmedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorSessionSlotId': doctorSessionSlotId,
      'userId': userId,
      'doctorId': doctorId,
      'bookingStatus': bookingStatus,
      'requestedAt': requestedAt,
      'confirmedAt': confirmedAt,
    };
  }
}
