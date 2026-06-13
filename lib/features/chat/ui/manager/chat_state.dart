part of 'chat_cubit.dart';

// ── States ─────────────────────────────────────────────────────────

abstract class ChatState {}

/// Initial state — emitted before [ChatCubit.initChat] is called.
class ChatInitialState extends ChatState {}

/// Primary state — holds messages + connection lifecycle + seen flag.
///
/// [connectionState] drives the UI banner (Connecting / Reconnecting /
/// Disconnected) without needing a separate state class.
///
/// [seenByOther] is set to `true` when a [ChatSeen] event fires.
/// The server sends no payload — the event arrival itself means "seen".
///
/// [errorMessage] carries non-fatal errors (e.g. send failure) so the
/// message list is preserved while the user is notified.
class ChatLoadedState extends ChatState {
  final List<ChatMessageEntity> messages;
  final ChatConnectionState connectionState;
  final bool seenByOther;
  final String? errorMessage;

  ChatLoadedState({
    required this.messages,
    this.connectionState = ChatConnectionState.connecting,
    this.seenByOther = false,
    this.errorMessage,
  });

  ChatLoadedState copyWith({
    List<ChatMessageEntity>? messages,
    ChatConnectionState? connectionState,
    bool? seenByOther,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatLoadedState(
      messages: messages ?? this.messages,
      connectionState: connectionState ?? this.connectionState,
      seenByOther: seenByOther ?? this.seenByOther,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Emitted when a fatal connection failure occurs.
class ChatErrorState extends ChatState {
  final String message;
  final ChatConnectionState connectionState;

  ChatErrorState({
    required this.message,
    this.connectionState = ChatConnectionState.error,
  });
}

/// One-shot state emitted when [BookingStatusChanged] fires.
/// Handled by [BlocListener] in [ChatScreen] — shown as a [SnackBar].
/// After handling, the Cubit resumes emitting [ChatLoadedState].
class BookingStatusUpdatedState extends ChatState {
  final BookingStatusEntity status;
  BookingStatusUpdatedState({required this.status});
}
