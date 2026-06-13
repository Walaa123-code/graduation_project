import 'package:mindecho/features/my_space/domain/entities/journal_entity.dart';

class JournalDM extends JournalEntity {
  JournalDM({
    required super.id,
    required super.title,
    required super.content,
    required super.date,
    required super.userId,
  });

  factory JournalDM.fromJson(Map<String, dynamic> json) {
    return JournalDM(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      date: json['date'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
    );
  }
}
