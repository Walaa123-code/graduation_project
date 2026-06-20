import '../../domain/entities/chat_history_entity.dart';
import 'chat_message_dm.dart';

class ChatHistoryDM extends ChatHistoryEntity {
  ChatHistoryDM({super.success, super.message, super.data, super.errors});

  factory ChatHistoryDM.fromJson(dynamic json) {
    return ChatHistoryDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((v) => ChatMessageDM.fromJson(v))
              .toList()
          : null,
      errors: json['errors'],
    );
  }
}
