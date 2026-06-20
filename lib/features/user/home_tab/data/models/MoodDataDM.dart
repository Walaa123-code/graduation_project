import '../../domain/entities/MoodDataEntity.dart';

class MoodDataDM extends MoodDataEntity {
  MoodDataDM({super.id, super.moodType, super.date});

  factory MoodDataDM.fromJson(Map<String, dynamic> json) {
    return MoodDataDM(
      id: json['id'],
      moodType: json['moodType'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moodType': moodType,
      'date': date,
    };
  }
}
