import '../../domain/entities/chat_message_entity.dart';

class ChatMessageDM extends ChatMessageEntity {
  ChatMessageDM({
    super.id,
    super.userId,
    super.sender,
    super.content,
    super.createdAt,
  });

  factory ChatMessageDM.fromJson(Map<String, dynamic> json) {
    return ChatMessageDM(
      id: json['id'],
      userId: json['userId'],
      sender: json['sender'],
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}
