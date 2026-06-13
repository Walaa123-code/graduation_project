import 'package:mindecho/features/chat/domain/entities/booking_status_entity.dart';

/// Data model for the [BookingStatusChanged] SignalR event payload.
///
/// The backend sends the exact key `doctorname` (lowercase 'n').
/// This is mapped to [doctorName] in the domain entity.
class BookingStatusDM extends BookingStatusEntity {
  const BookingStatusDM({
    required super.message,
    required super.status,
    required super.doctorName,
  });

  /// Defensive factory — all fields fall back to empty string if absent.
  factory BookingStatusDM.fromJson(Map<String, dynamic> json) =>
      BookingStatusDM(
        message: ((json['message'] ?? '') as Object).toString(),
        status: ((json['status'] ?? '') as Object).toString(),
        // Exact backend key: 'doctorname' (lowercase n)
        doctorName: ((json['doctorname'] ?? '') as Object).toString(),
      );
}
