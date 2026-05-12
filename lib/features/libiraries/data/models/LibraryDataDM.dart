import '../../domain/entities/LibraryDateEntity.dart';

class LibraryDataDM extends LibraryDataEntity {
  LibraryDataDM({
    super.id,
    super.title,
    super.imageUrl,
    super.contentUrl,
    super.type,
    super.mood,
  });

  factory LibraryDataDM.fromJson(Map<String, dynamic> json) {
    return LibraryDataDM(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      contentUrl: json['contentUrl'],
      type: json['type'],
      mood: json['mood'],
    );
  }
}
