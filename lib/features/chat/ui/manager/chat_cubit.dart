import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:mindecho/features/chat/domain/repositories/chat_repository.dart';
import 'package:mindecho/features/chat/domain/use_cases/chat_use_cases.dart';

part 'chat_state.dart';

// ── Connection lifecycle enum ──────────────────────────────────────

/// Represents the SignalR hub connection lifecycle.
/// Driven by [ChatSignalRService]'s [onreconnecting] / [onreconnected] /
/// [onclose] callbacks.
enum ChatConnectionState {
  connecting,
  connected,
  reconnecting,
  disconnected,
  error,
}

// ── Cubit ──────────────────────────────────────────────────────────

class ChatCubit extends Cubit<ChatState> {
  final ConnectChatUseCase connectChatUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final DisconnectChatUseCase disconnectChatUseCase;
  final ChatRepository chatRepository;

  StreamSubscription<ChatMessageEntity>?       _msgSub;
  StreamSubscription<List<ChatMessageEntity>>? _historySub;
  StreamSubscription<void>?                    _seenSub;
  StreamSubscription<BookingStatusEntity>?     _statusSub;
  StreamSubscription<ChatConnectionState>?     _connSub;

  ChatCubit({
    required this.connectChatUseCase,
    required this.sendMessageUseCase,
    required this.markAsReadUseCase,
    required this.disconnectChatUseCase,
    required this.chatRepository,
  }) : super(ChatInitialState());

  // ── Public API ─────────────────────────────────────────────────

  /// Opens the chat: subscribes to all streams → connects → joins room →
  /// loads history.  Must be called from [ChatScreen.initState].
  Future<void> initChat(int bookingId) async {
    // Emit connecting state immediately
    emit(ChatLoadedState(
      messages: const [],
      connectionState: ChatConnectionState.connecting,
    ));

    // Subscribe BEFORE connect so no events are missed during setup
    _subscribeToStreams();

    try {
      await connectChatUseCase(bookingId);
    } catch (e) {
      emit(ChatErrorState(
        message: 'Failed to connect: $e',
        connectionState: ChatConnectionState.error,
      ));
    }
  }

  /// Sends a message to the booking room with an optimistic UI update.
  Future<void> sendMessage(int bookingId, String content, int senderType) async {
    final current = _currentLoaded();
    if (current != null) {
      // Optimistic append
      final optimisticMsg = ChatMessageEntity(
        content: content,
        sentAt: DateTime.now(),
        messageSenderType: senderType,
      );
      emit(current.copyWith(messages: [...current.messages, optimisticMsg]));
    }

    try {
      await sendMessageUseCase(bookingId, content);
    } catch (e) {
      // Non-fatal — update errorMessage (we keep the optimistic message for now,
      // or we could remove it if we want strict failure handling)
      final stateAfter = _currentLoaded();
      if (stateAfter != null) {
        emit(stateAfter.copyWith(errorMessage: 'Send failed: $e'));
      }
    }
  }

  /// Marks the other side's messages as read.
  /// Call when incoming messages become visible on screen.
  Future<void> markAsRead(int bookingId) async {
    try {
      await markAsReadUseCase(bookingId);
    } catch (e) {
      // Silent — MarkAsRead failures are non-critical
    }
  }

  // ── Stream subscriptions ───────────────────────────────────────

  void _subscribeToStreams() {
    // ReceiveMessage → append new message to the current list (with deduplication)
    _msgSub = chatRepository.messageStream.listen((msg) {
      final current = _currentLoaded();
      var messages = current?.messages.toList() ?? [];

      // Deduplicate optimistic messages by content, sender, and approximate time
      final existingIndex = messages.indexWhere((m) =>
          m.content == msg.content &&
          m.messageSenderType == msg.messageSenderType &&
          m.sentAt.difference(msg.sentAt).abs().inSeconds < 10);

      if (existingIndex != -1) {
        messages[existingIndex] = msg; // Replace optimistic with server confirmed
      } else {
        messages.add(msg);
      }

      emit(ChatLoadedState(
        messages: messages,
        connectionState: current?.connectionState ?? ChatConnectionState.connected,
        seenByOther: current?.seenByOther ?? false,
      ));
    });

    // LoadMessages → replace the full message list (history load)
    _historySub = chatRepository.historyStream.listen((history) {
      final current = _currentLoaded();
      emit(ChatLoadedState(
        messages: history,
        connectionState: current?.connectionState ?? ChatConnectionState.connected,
        seenByOther: current?.seenByOther ?? false,
      ));
    });

    // ChatSeen → flip seenByOther flag; no payload from server
    _seenSub = chatRepository.seenStream.listen((_) {
      final current = _currentLoaded();
      if (current != null) {
        emit(current.copyWith(seenByOther: true));
      }
    });

    // BookingStatusChanged → one-shot side-effect state for BlocListener
    _statusSub = chatRepository.statusStream.listen((status) {
      emit(BookingStatusUpdatedState(status: status));
    });

    // Connection lifecycle → update connectionState in ChatLoadedState
    _connSub = chatRepository.connectionStateStream.listen((connState) {
      final current = _currentLoaded();
      if (current != null) {
        emit(current.copyWith(connectionState: connState));
      } else if (connState == ChatConnectionState.error) {
        emit(ChatErrorState(
          message: 'Connection error',
          connectionState: connState,
        ));
      }
    });
  }

  // ── Helpers ────────────────────────────────────────────────────

  ChatLoadedState? _currentLoaded() =>
      state is ChatLoadedState ? state as ChatLoadedState : null;

  // ── Dispose ────────────────────────────────────────────────────

  @override
  Future<void> close() async {
    await _msgSub?.cancel();
    await _historySub?.cancel();
    await _seenSub?.cancel();
    await _statusSub?.cancel();
    await _connSub?.cancel();
    await disconnectChatUseCase();
    return super.close();
  }
}
