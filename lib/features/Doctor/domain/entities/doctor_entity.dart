class DoctorProfileEntity {
  final String id;
  final String fullName;
  final String? email;
  final int gender;
  final int age;
  final String? specialization;
  final String? bio;
  final String? profilePicture;

  const DoctorProfileEntity({
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

class DoctorListEntity {
  final List<DoctorProfileEntity> doctors;
  final int totalCount;

  const DoctorListEntity({
    required this.doctors,
    required this.totalCount,
  });
}
