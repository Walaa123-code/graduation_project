import '../../domain/entities/GetAllMoodResponseEntity.dart';
import 'MoodDataDM.dart';

class GetAllMoodsResponseDM extends GetAllMoodResponseEntity {
  GetAllMoodsResponseDM({super.success, super.message, super.data, super.errors});

  factory GetAllMoodsResponseDM.fromJson(dynamic json) {
    return GetAllMoodsResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((v) => MoodDataDM.fromJson(v))
              .toList()
          : null,
      errors: json['errors'],
    );
  }
}
