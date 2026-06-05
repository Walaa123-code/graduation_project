part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}
final class ChatConnectingState extends ChatState {}
final class ChatConnectedState extends ChatState {}
final class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState({required this.message});
}

// Messages loaded
final class ChatMessagesLoadedState extends ChatState {
  final List<ChatMessageEntity> messages;
  ChatMessagesLoadedState({required this.messages});
}

// New message received
final class ChatNewMessageState extends ChatState {
  final List<ChatMessageEntity> messages;
  ChatNewMessageState({required this.messages});
}

// Chat seen
final class ChatSeenState extends ChatState {}

// Booking status changed
final class BookingStatusChangedState extends ChatState {
  final BookingStatusChangedEntity statusData;
  BookingStatusChangedState({required this.statusData});
}
