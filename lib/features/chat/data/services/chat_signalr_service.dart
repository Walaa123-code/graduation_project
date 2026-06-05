import 'package:mindecho/core/api/api_constants.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_changed_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ChatSignalRService {
  HubConnection? _connection;
  bool _isConnected = false;

  // Callbacks
  Function(ChatMessageEntity)? onReceiveMessage;
  Function(List<ChatMessageEntity>)? onLoadMessages;
  Function()? onChatSeen;
  Function(BookingStatusChangedEntity)? onBookingStatusChanged;

  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<void> connect() async {
    if (_isConnected) return;

    final token = _getToken();
    _connection = HubConnectionBuilder()
        .withUrl(
          '${ApiConstants.baseUrl}/chatHub',
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token ?? '',
          ),
        )
        .withAutomaticReconnect()
        .build();

    // Server → Client listeners
    _connection!.on('ReceiveMessage', (args) {
      if (args == null || args.isEmpty) return;
      final data = args[0] as Map<String, dynamic>;
      onReceiveMessage?.call(_parseMessage(data));
    });

    _connection!.on('LoadMessages', (args) {
      if (args == null || args.isEmpty) return;
      final list = args[0] as List<dynamic>;
      final messages = list
          .map((e) => _parseMessage(e as Map<String, dynamic>))
          .toList();
      onLoadMessages?.call(messages);
    });

    _connection!.on('ChatSeen', (_) {
      onChatSeen?.call();
    });

    _connection!.on('BookingStatusChanged', (args) {
      if (args == null || args.isEmpty) return;
      final data = args[0] as Map<String, dynamic>;
      onBookingStatusChanged?.call(BookingStatusChangedEntity(
        message: data['message'],
        status: data['status'],
        doctorName: data['doctorname'],
      ));
    });

    await _connection!.start();
    _isConnected = true;
  }

  // Client → Server methods
  Future<void> joinChat(int bookingId) async {
    await _ensureConnected();
    await _connection!.invoke('JoinChat', args: [bookingId]);
  }

  Future<void> sendMessage(int bookingId, String content) async {
    await _ensureConnected();
    await _connection!.invoke('SendMessage', args: [bookingId, content]);
  }

  Future<void> markAsRead(int bookingId) async {
    await _ensureConnected();
    await _connection!.invoke('MarkAsRead', args: [bookingId]);
  }

  Future<void> loadMessages(int bookingId) async {
    await _ensureConnected();
    await _connection!.invoke('LoadMessages', args: [bookingId]);
  }

  Future<void> disconnect() async {
    await _connection?.stop();
    _isConnected = false;
  }

  Future<void> _ensureConnected() async {
    if (!_isConnected) await connect();
  }

  ChatMessageEntity _parseMessage(Map<String, dynamic> data) {
    return ChatMessageEntity(
      chatId: data['chatId'],
      senderId: data['senderId'],
      content: data['content'],
      senderType: data['senderType'],
      createdAt: data['createdAt'],
    );
  }
}
