import 'package:mindecho/features/appointments/domain/entities/booking_entity.dart';

class BookingDM extends BookingEntity {
  BookingDM({
    required super.id,
    required super.doctorSessionSlotId,
    required super.userId,
    required super.doctorId,
    required super.bookingStatus,
    required super.requestedAt,
    super.confirmedAt,
    super.doctor,
  });

  factory BookingDM.fromJson(Map<String, dynamic> json) {
    return BookingDM(
      id: json['id'] as int? ?? 0,
      doctorSessionSlotId: json['doctorSessionSlotId'] as int? ?? 0,
      userId: json['userId'] as String? ?? '',
      doctorId: json['doctorId'] as String? ?? '',
      bookingStatus: json['bookingStatus'] as int? ?? 0,
      requestedAt: json['requestedAt'] as String? ?? '',
      confirmedAt: json['confirmedAt'] as String?,
      doctor: json['doctor'] != null
          ? DoctorDM.fromJson(json['doctor'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DoctorDM extends DoctorEntity {
  DoctorDM({
    required super.id,
    required super.fullName,
    super.email,
    required super.gender,
    required super.age,
    super.specialization,
    super.bio,
    super.profilePicture,
  });

  factory DoctorDM.fromJson(Map<String, dynamic> json) {
    return DoctorDM(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String?,
      gender: json['gender'] as int? ?? 0,
      age: json['age'] as int? ?? 0,
      specialization: json['specialization'] as String?,
      bio: json['bio'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );
  }
}
