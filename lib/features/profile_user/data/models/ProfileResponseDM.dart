import 'package:mindecho/features/profile_user/domain/entities/ProfileResponseEntity.dart';

class ProfileResponseDm extends ProfileResponseEntity {
  ProfileResponseDm({
    super.success,
    super.message,
    super.data,
    super.errors,
  });

  ProfileResponseDm.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataDM.fromJson(json['data']) : null;
    errors = json['errors'];
    // != null ? ErrorsDM.fromJson(json['errors']) : null;
  }
}

class DataDM extends DataEntity {
  DataDM({
    super.id,
    super.fullName,
    super.email,
    super.gender,
    super.age,
    super.profilePicture,
  });

  DataDM.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    profilePicture = json['profilePicture'];
  }
}
