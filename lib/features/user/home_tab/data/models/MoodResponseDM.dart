import '../../domain/entities/MoodResponseEntity.dart';
import 'MoodDataDM.dart';

class MoodResponseDM extends MoodResponseEntity {
  MoodResponseDM({super.success, super.message, super.data, super.errors});

  factory MoodResponseDM.fromJson(dynamic json) {
    return MoodResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? MoodDataDM.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}
