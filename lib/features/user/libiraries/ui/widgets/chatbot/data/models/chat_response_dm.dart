import '../../domain/entities/chat_response_entity.dart';

class ChatResponseDM extends ChatResponseEntity {
  ChatResponseDM({super.success, super.message, super.data, super.errors});

  factory ChatResponseDM.fromJson(dynamic json) {
    return ChatResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ChatReplyDataDM.fromJson(json['data'])
          : null,
      errors: json['errors'],
    );
  }
}

class ChatReplyDataDM extends ChatReplyDataEntity {
  ChatReplyDataDM({super.reply, super.emotion, super.practice, super.error});

  factory ChatReplyDataDM.fromJson(Map<String, dynamic> json) {
    return ChatReplyDataDM(
      reply: json['reply'],
      emotion: json['emotion'],
      practice: json['practice'],
      error: json['error'],
    );
  }
}
