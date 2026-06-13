class Patient {
  final String id;
  final String name;
  final String imageUrl;
  final String lastStatus;
  final String lastStatusEmoji;
  final String lastSeen;

  const Patient({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastStatus,
    required this.lastStatusEmoji,
    required this.lastSeen,
  });
}
