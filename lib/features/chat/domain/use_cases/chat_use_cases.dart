import 'package:mindecho/features/chat/domain/repositories/chat_repository.dart';

// ── ConnectChatUseCase ────────────────────────────────────────────

/// Starts the SignalR connection, joins the booking room, and loads history.
///
/// Sequence (performed inside the repository):
///   connection.start()
///   invoke("JoinChat",     args: [bookingId])
///   invoke("LoadMessages", args: [bookingId])
class ConnectChatUseCase {
  final ChatRepository chatRepository;
  ConnectChatUseCase({required this.chatRepository});

  Future<void> call(int bookingId) => chatRepository.connect(bookingId);
}

// ── SendMessageUseCase ────────────────────────────────────────────

/// Sends a message to the booking chat room.
///   invoke("SendMessage", args: [bookingId, content])
class SendMessageUseCase {
  final ChatRepository chatRepository;
  SendMessageUseCase({required this.chatRepository});

  Future<void> call(int bookingId, String content) =>
      chatRepository.sendMessage(bookingId, content);
}

// ── MarkAsReadUseCase ─────────────────────────────────────────────

/// Marks the other side's messages as read.
///   invoke("MarkAsRead", args: [bookingId])
///
/// Should be called when incoming (other-side) messages become visible.
class MarkAsReadUseCase {
  final ChatRepository chatRepository;
  MarkAsReadUseCase({required this.chatRepository});

  Future<void> call(int bookingId) => chatRepository.markAsRead(bookingId);
}

// ── DisconnectChatUseCase ─────────────────────────────────────────

/// Stops the hub connection and releases all resources.
/// Called from [ChatCubit.close] when the screen is disposed.
class DisconnectChatUseCase {
  final ChatRepository chatRepository;
  DisconnectChatUseCase({required this.chatRepository});

  Future<void> call() => chatRepository.disconnect();
}
