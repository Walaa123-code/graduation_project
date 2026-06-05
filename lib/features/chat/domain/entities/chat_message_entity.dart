class ChatMessageEntity {
  ChatMessageEntity({
    this.chatId,
    this.senderId,
    this.content,
    this.senderType,
    this.createdAt,
  });

  num? chatId;
  String? senderId;
  String? content;
  String? senderType; // "User" or "Doctor"
  String? createdAt;
}
