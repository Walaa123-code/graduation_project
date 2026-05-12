class BookingDataEntity {
  BookingDataEntity({
    this.id,
    this.doctorSessionSlotId,
    this.userId,
    this.doctorId,
    this.bookingStatus,
    this.requestedAt,
    this.confirmedAt,
  });

  num? id;
  num? doctorSessionSlotId;
  String? userId;
  String? doctorId;
  num? bookingStatus; // 0 = Pending, 1 = Confirmed, 2 = Cancelled, 3 = Completed
  String? requestedAt;
  String? confirmedAt;
}
