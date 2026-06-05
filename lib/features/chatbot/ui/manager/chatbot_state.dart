part of 'chatbot_cubit.dart';

@immutable
sealed class ChatBotState {}

final class ChatBotInitialState extends ChatBotState {}

// History
final class ChatHistoryLoadingState extends ChatBotState {}
final class ChatHistorySuccessState extends ChatBotState {
  final ChatHistoryEntity historyEntity;
  ChatHistorySuccessState({required this.historyEntity});
}
final class ChatHistoryErrorState extends ChatBotState {
  final Failures failures;
  ChatHistoryErrorState({required this.failures});
}

// Send Message
final class SendMessageLoadingState extends ChatBotState {}
final class SendMessageSuccessState extends ChatBotState {
  final ChatResponseEntity responseEntity;
  SendMessageSuccessState({required this.responseEntity});
}
final class SendMessageErrorState extends ChatBotState {
  final Failures failures;
  SendMessageErrorState({required this.failures});
}
