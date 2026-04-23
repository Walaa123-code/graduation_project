import 'package:graduation_project/features/home_tab/domain/entities/MoodResponseEntity.dart';

class MoodResponseDM extends MoodResponseEntity {
  MoodResponseDM({
    required super.id,
    required super.moodType,
    required super.date,
  });

  factory MoodResponseDM.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];

    return MoodResponseDM(
      id: dataJson['id'] ?? 0,
      moodType: dataJson['moodType'] ?? 0,
      date: dataJson['date'] ?? '',
    );
  }
}
