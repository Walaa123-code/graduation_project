import '../../domain/entities/JournalDataEntity.dart';

class JournalDataDM extends JournalDataEntity {
  JournalDataDM({
    super.id,
    super.title,
    super.content,
    super.date,
    super.userId,
  });

  factory JournalDataDM.fromJson(Map<String, dynamic> json) {
    return JournalDataDM(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'userId': userId,
    };
  }
}
