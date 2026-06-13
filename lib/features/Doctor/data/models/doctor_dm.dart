import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';

class DoctorProfileDM extends DoctorProfileEntity {
  DoctorProfileDM({
    required super.id,
    required super.fullName,
    super.email,
    required super.gender,
    required super.age,
    super.specialization,
    super.bio,
    super.profilePicture,
  });

  factory DoctorProfileDM.fromJson(Map<String, dynamic> json) {
    return DoctorProfileDM(
      id: (json['id'] ?? json['Id']) as String? ?? '',
      fullName: (json['fullName'] ?? json['FullName']) as String? ?? '',
      email: (json['email'] ?? json['Email']) as String?,
      gender: (json['gender'] ?? json['Gender']) as int? ?? 0,
      age: (json['age'] ?? json['Age']) as int? ?? 0,
      specialization: (json['specialization'] ?? json['Specialization']) as String?,
      bio: (json['bio'] ?? json['Bio']) as String?,
      profilePicture: (json['profilePicture'] ?? json['ProfilePicture']) as String?,
    );
  }
}

class DoctorListDM extends DoctorListEntity {
  DoctorListDM({required super.doctors, required super.totalCount});

  /// The API returns: { "data": [ { "doctors": [...], "totalCount": N } ] }
  factory DoctorListDM.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>? ?? [];
    if (dataList.isEmpty) {
      return DoctorListDM(doctors: [], totalCount: 0);
    }
    final first = dataList.first as Map<String, dynamic>;
    final doctorsList = (first['doctors'] as List<dynamic>? ?? [])
        .map((e) => DoctorProfileDM.fromJson(e as Map<String, dynamic>))
        .toList();
    return DoctorListDM(
      doctors: doctorsList,
      totalCount: first['totalCount'] as int? ?? 0,
    );
  }
}
