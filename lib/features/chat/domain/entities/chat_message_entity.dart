/// Domain entity for a single chat message received from the SignalR hub.
///
/// Field names match the confirmed backend payload keys:
///   content / Content
///   sentAt  / SentAt   (parsed to [DateTime] in the data layer)
///   messageSenderType / MessageSenderType  (0 = User, 1 = Doctor)
class ChatMessageEntity {
  final int? chatId;
  final String? senderId;
  final String content;
  final DateTime sentAt;
  final int messageSenderType;

  const ChatMessageEntity({
    this.chatId,
    this.senderId,
    required this.content,
    required this.sentAt,
    required this.messageSenderType,
  });

  /// Convenience getter — avoids exposing the raw int enum to the UI.
  bool get isDoctor => messageSenderType == 1;
  bool get isUser   => messageSenderType == 0;
}
