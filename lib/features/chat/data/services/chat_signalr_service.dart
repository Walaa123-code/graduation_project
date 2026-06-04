import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'package:mindecho/core/api/api_constants.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/cashe_helper.dart';
import 'package:mindecho/features/chat/data/models/booking_status_dm.dart';
import 'package:mindecho/features/chat/data/models/chat_message_dm.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart'
    show ChatConnectionState;

/// Low-level SignalR hub wrapper.
///
/// Responsibilities:
///   • Build and manage the [HubConnection] lifecycle.
///   • Register all 4 server→client event listeners with defensive parsing.
///   • Expose broadcast [Stream]s consumed by [ChatRepositoryImpl].
///   • Handle automatic reconnect via [onreconnecting] / [onreconnected] /
///     [onclose] hooks.
///   • Log every event and connection change with [debugPrint] using the
///     `[Chat]` prefix.  Remove all logs before production release.
class ChatSignalRService {
  // ── Hub connection ─────────────────────────────────────────────
  late final HubConnection _connection;

  // Stores the current bookingId so reconnect can re-join the room.
  int? _currentBookingId;

  // ── Broadcast StreamControllers ────────────────────────────────
  final _messageController =
      StreamController<ChatMessageEntity>.broadcast();
  final _historyController =
      StreamController<List<ChatMessageEntity>>.broadcast();
  final _seenController = StreamController<void>.broadcast();
  final _statusController =
      StreamController<BookingStatusEntity>.broadcast();
  final _connectionStateController =
      StreamController<ChatConnectionState>.broadcast();

  // ── Public streams ─────────────────────────────────────────────
  Stream<ChatMessageEntity>       get messageStream         => _messageController.stream;
  Stream<List<ChatMessageEntity>> get historyStream         => _historyController.stream;
  Stream<void>                    get seenStream            => _seenController.stream;
  Stream<BookingStatusEntity>     get statusStream          => _statusController.stream;
  Stream<ChatConnectionState>     get connectionStateStream => _connectionStateController.stream;

  // ── Constructor ────────────────────────────────────────────────
  ChatSignalRService() {
    _connection = HubConnectionBuilder()
        .withUrl(
          // Single source of truth — never hardcode the URL elsewhere.
          ApiConstants.baseUrl + EndPoints.chatHub,
          options: HttpConnectionOptions(
            // Reuses the same JWT token already in use by Dio requests.
            // The ngrok browser-warning header is not needed here:
            // Flutter's SignalR client connects via WebSocket, which
            // bypasses the ngrok browser warning page entirely.
            accessTokenFactory: () async =>
                await CasheHelper.getToken() ?? '',
          ),
        )
        .withAutomaticReconnect()
        .build();

    _registerLifecycleHooks();
    _registerEventListeners();
  }

  // ── Lifecycle hooks ────────────────────────────────────────────

  void _registerLifecycleHooks() {
    _connection.onreconnecting(({Exception? error}) {
      debugPrint('[Chat] Reconnecting... error=$error');
      _connectionStateController.add(ChatConnectionState.reconnecting);
    });

    _connection.onreconnected(({String? connectionId}) async {
      debugPrint('[Chat] Reconnected. connectionId=$connectionId  '
          'Re-joining bookingId=$_currentBookingId');
      _connectionStateController.add(ChatConnectionState.connected);
      if (_currentBookingId != null) {
        await _connection.invoke('JoinChat',
            args: <Object>[_currentBookingId!]);
        await _connection.invoke('LoadMessages',
            args: <Object>[_currentBookingId!]);
      }
    });

    _connection.onclose(({Exception? error}) {
      debugPrint('[Chat] Connection closed. error=$error');
      _connectionStateController.add(
        error != null
            ? ChatConnectionState.error
            : ChatConnectionState.disconnected,
      );
    });
  }

  // ── Event listeners (exact backend event names) ────────────────

  void _registerEventListeners() {
    // ── ReceiveMessage ──────────────────────────────────────────
    _connection.on('ReceiveMessage', (List<Object?>? args) {
      // PHASE 1 LOG — remove before production release
      debugPrint('[Chat][ReceiveMessage] raw args: $args');

      if (args == null || args.isEmpty) return;
      try {
        final payload = args[0] as Map<String, dynamic>;
        final msg = ChatMessageDM.fromJson(payload);
        _messageController.add(msg);
      } catch (e) {
        debugPrint('[Chat][ReceiveMessage] parse error: $e  args=$args');
      }
    });

    // ── LoadMessages ────────────────────────────────────────────
    _connection.on('LoadMessages', (List<Object?>? args) {
      // PHASE 1 LOG — remove before production release
      debugPrint('[Chat][LoadMessages] raw args: $args');

      if (args == null || args.isEmpty) return;
      try {
        // listFromRawArgs handles both List<dynamic> and unexpected types
        // gracefully — inspect the log above to verify actual structure.
        final list = ChatMessageDM.listFromRawArgs(args[0]);
        _historyController.add(list);
      } catch (e) {
        debugPrint('[Chat][LoadMessages] parse error: $e  args=$args');
      }
    });

    // ── ChatSeen ────────────────────────────────────────────────
    // ChatSeen is parameterless — no payload is inspected.
    _connection.on('ChatSeen', (List<Object?>? _) {
      // PHASE 1 LOG — remove before production release
      debugPrint('[Chat][ChatSeen] event received (no payload)');
      _seenController.add(null);
    });

    // ── BookingStatusChanged ─────────────────────────────────────
    _connection.on('BookingStatusChanged', (List<Object?>? args) {
      // PHASE 1 LOG — remove before production release
      debugPrint('[Chat][BookingStatusChanged] raw args: $args');

      if (args == null || args.isEmpty) return;
      try {
        final payload = args[0] as Map<String, dynamic>;
        final status = BookingStatusDM.fromJson(payload);
        _statusController.add(status);
      } catch (e) {
        debugPrint(
            '[Chat][BookingStatusChanged] parse error: $e  args=$args');
      }
    });
  }

  // ── Client → Server invocations ───────────────────────────────

  /// Starts the hub, joins the booking room, and requests message history.
  Future<void> connect(int bookingId) async {
    _currentBookingId = bookingId;
    _connectionStateController.add(ChatConnectionState.connecting);

    debugPrint('[Chat] Starting connection to '
        '${ApiConstants.baseUrl}${EndPoints.chatHub}');
    await _connection.start();

    _connectionStateController.add(ChatConnectionState.connected);
    debugPrint('[Chat] Connection started successfully. '
        'Invoking JoinChat(bookingId=$bookingId)');

    await _connection.invoke('JoinChat', args: <Object>[bookingId]);
    debugPrint('[Chat] JoinChat invoked. Requesting LoadMessages...');

    await _connection.invoke('LoadMessages', args: <Object>[bookingId]);
    debugPrint('[Chat] LoadMessages invoked.');
  }

  /// Sends a message to the booking room.
  ///   invoke("SendMessage", args: [bookingId, content])
  Future<void> sendMessage(int bookingId, String content) async {
    await _connection.invoke('SendMessage', args: <Object>[bookingId, content]);
  }

  /// Marks the other side's messages as read.
  ///   invoke("MarkAsRead", args: [bookingId])
  Future<void> markAsRead(int bookingId) async {
    await _connection.invoke('MarkAsRead', args: <Object>[bookingId]);
  }

  /// Stops the hub connection and closes all stream controllers.
  /// Called from [ChatCubit.close] when the screen is disposed.
  Future<void> dispose() async {
    debugPrint('[Chat] Disposing service — stopping connection.');
    try {
      await _connection.stop();
    } catch (e) {
      debugPrint('[Chat] Error stopping connection: $e');
    }
    await _messageController.close();
    await _historyController.close();
    await _seenController.close();
    await _statusController.close();
    await _connectionStateController.close();
  }
}
