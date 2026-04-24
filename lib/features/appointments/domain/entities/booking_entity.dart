/// Represents a single booking returned from the API.
class BookingEntity {
  final int id;
  final int doctorSessionSlotId;
  final String userId;
  final String doctorId;
  final int bookingStatus; // 0=Pending, 1=Confirmed, 2=Cancelled, 3=Completed
  final String requestedAt;
  final String? confirmedAt;
  final DoctorEntity? doctor;

  const BookingEntity({
    required this.id,
    required this.doctorSessionSlotId,
    required this.userId,
    required this.doctorId,
    required this.bookingStatus,
    required this.requestedAt,
    this.confirmedAt,
    this.doctor,
  });
}

class DoctorEntity {
  final String id;
  final String fullName;
  final String? email;
  final int gender;
  final int age;
  final String? specialization;
  final String? bio;
  final String? profilePicture;

  const DoctorEntity({
    required this.id,
    required this.fullName,
    this.email,
    required this.gender,
    required this.age,
    this.specialization,
    this.bio,
    this.profilePicture,
  });
}
