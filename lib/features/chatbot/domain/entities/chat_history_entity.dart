import 'chat_message_entity.dart';

class ChatHistoryEntity {
  ChatHistoryEntity({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  List<ChatMessageEntity>? data;
  dynamic errors;
}
