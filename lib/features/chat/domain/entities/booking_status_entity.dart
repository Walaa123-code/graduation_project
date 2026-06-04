/// Domain entity for the [BookingStatusChanged] SignalR event.
///
/// Backend payload keys:
///   message    → [message]
///   status     → [status]
///   doctorname → [doctorName]  (note: lowercase 'n' in JSON key)
class BookingStatusEntity {
  final String message;
  final String status;
  final String doctorName;

  const BookingStatusEntity({
    required this.message,
    required this.status,
    required this.doctorName,
  });
}
