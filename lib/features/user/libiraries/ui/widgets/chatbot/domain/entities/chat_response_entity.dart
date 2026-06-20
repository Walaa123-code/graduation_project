class ChatResponseEntity {
  ChatResponseEntity({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  bool? success;
  String? message;
  ChatReplyDataEntity? data;
  dynamic errors;
}

class ChatReplyDataEntity {
  ChatReplyDataEntity({
    this.reply,
    this.emotion,
    this.practice,
    this.error,
  });

  String? reply;
  String? emotion;
  List<dynamic>? practice;
  dynamic error;
}
