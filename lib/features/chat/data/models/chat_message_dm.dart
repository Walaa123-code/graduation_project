import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';

/// Data model for a single chat message.
///
/// Extends [ChatMessageEntity] and adds a defensive [fromJson] that accepts
/// both camelCase and PascalCase keys to handle any SignalR serialisation
/// quirks.
///
/// [sentAt] is parsed from an ISO 8601 string in the data layer so the
/// domain entity stays strongly typed as [DateTime].
class ChatMessageDM extends ChatMessageEntity {
  const ChatMessageDM({
    super.chatId,
    super.senderId,
    required super.content,
    required super.sentAt,
    required super.messageSenderType,
  });

  /// Defensive factory — accepts camelCase or PascalCase keys.
  factory ChatMessageDM.fromJson(Map<String, dynamic> json) {
    final rawSentAt =
        ((json['sentAt'] ?? json['SentAt'] ?? '') as Object).toString();

    return ChatMessageDM(
      chatId: (json['chatId'] ?? json['ChatId']) as int?,
      senderId:
          ((json['senderId'] ?? json['SenderId']) as Object?)?.toString(),
      content:
          ((json['content'] ?? json['Content'] ?? '') as Object).toString(),
      sentAt: rawSentAt.isEmpty
          ? DateTime.now()
          : DateTime.tryParse(rawSentAt) ?? DateTime.now(),
      messageSenderType:
          (json['messageSenderType'] ?? json['MessageSenderType'] ?? 0) as int,
    );
  }

  /// Parses the raw [args[0]] value from a [LoadMessages] SignalR event.
  ///
  /// The backend sends the history as a JSON array. This helper handles:
  ///   • [List<dynamic>]       — direct array (most likely)
  ///   • anything else         — logs and returns empty list
  ///
  /// NOTE: During Phase 1 the [ChatSignalRService] also prints the raw args
  /// via [debugPrint] so the exact structure can be confirmed at runtime.
  static List<ChatMessageDM> listFromRawArgs(dynamic raw) {
    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map(ChatMessageDM.fromJson)
          .toList();
    }
    return [];
  }
}
