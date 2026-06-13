class JournalEntity {
  final int id;
  final String title;
  final String content;
  final String date;
  final String userId;

  const JournalEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
  });
}
