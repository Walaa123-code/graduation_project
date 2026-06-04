import 'package:mindecho/features/chat/domain/entities/booking_status_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart'
    show ChatConnectionState;

/// Abstract interface for the chat SignalR repository.
///
/// Consumers subscribe to streams and invoke methods.
/// All streams are broadcast streams (multiple listeners allowed).
abstract class ChatRepository {
  // ── Server → Client streams ────────────────────────────────────

  /// Fires each time a [ReceiveMessage] event arrives from the hub.
  Stream<ChatMessageEntity> get messageStream;

  /// Fires when a [LoadMessages] event arrives — contains full history.
  Stream<List<ChatMessageEntity>> get historyStream;

  /// Fires when a [ChatSeen] event arrives.
  /// [ChatSeen] is parameterless — the void signal itself means "seen".
  Stream<void> get seenStream;

  /// Fires when a [BookingStatusChanged] event arrives.
  Stream<BookingStatusEntity> get statusStream;

  /// Fires on connection lifecycle changes (connecting / connected /
  /// reconnecting / disconnected / error).
  Stream<ChatConnectionState> get connectionStateStream;

  // ── Client → Server invocations ───────────────────────────────

  /// Connects to the hub, joins the booking room, and requests history.
  ///
  /// Sequence:
  ///   connection.start()
  ///   invoke("JoinChat",     args: [bookingId])
  ///   invoke("LoadMessages", args: [bookingId])
  Future<void> connect(int bookingId);

  /// Sends a chat message.
  ///   invoke("SendMessage", args: [bookingId, content])
  Future<void> sendMessage(int bookingId, String content);

  /// Marks the other side's messages as read.
  ///   invoke("MarkAsRead", args: [bookingId])
  Future<void> markAsRead(int bookingId);

  /// Stops the hub connection and releases resources.
  Future<void> disconnect();
}
