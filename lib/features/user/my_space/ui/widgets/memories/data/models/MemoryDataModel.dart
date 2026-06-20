import '../../domain/entities/MemoryDataEntity.dart';

class MemoryDataDM extends MemoryDataEntity {
  MemoryDataDM({
    super.id,
    super.title,
    super.moodState,
    super.date,
    super.imageUrl,
  });

  factory MemoryDataDM.fromJson(Map<String, dynamic> json) {
    return MemoryDataDM(
      id: json['id'],
      title: json['title'],
      moodState: json['moodState'],
      date: json['date'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['moodState'] = moodState;
    map['date'] = date;
    map['imageUrl'] = imageUrl;
    return map;
  }
}
