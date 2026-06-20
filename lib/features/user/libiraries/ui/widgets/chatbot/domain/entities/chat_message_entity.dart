class ChatMessageEntity {
  ChatMessageEntity({
    this.id,
    this.userId,
    this.sender,
    this.content,
    this.createdAt,
  });

  num? id;
  String? userId;
  String? sender; // "User" or "Bot"
  String? content;
  String? createdAt;
}
