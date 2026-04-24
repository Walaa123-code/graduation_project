class MemoryEntity {
  final int id;
  final String title;
  final String imagePath;
  final int moodState;
  final String userId;

  const MemoryEntity({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.moodState,
    required this.userId,
  });
}
