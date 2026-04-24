import 'package:mindecho/features/my_space/domain/entities/memory_entity.dart';

class MemoryDM extends MemoryEntity {
  MemoryDM({
    required super.id,
    required super.title,
    required super.imagePath,
    required super.moodState,
    required super.userId,
  });

  factory MemoryDM.fromJson(Map<String, dynamic> json) {
    return MemoryDM(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      imagePath: json['imagePath'] as String? ?? '',
      moodState: json['moodState'] as int? ?? 0,
      userId: json['userId'] as String? ?? '',
    );
  }
}
