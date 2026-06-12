import 'package:mindecho/features/chat/data/services/chat_signalr_service.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';


/// Interface for the remote data source handling chat operations.
abstract class ChatRemoteDataSource {
  Stream<ChatMessageEntity> get messageStream;
  Stream<List<ChatMessageEntity>> get historyStream;
  Stream<void> get seenStream;
  Stream<BookingStatusEntity> get statusStream;
  Stream<ChatConnectionState> get connectionStateStream;

  Future<void> connect(int bookingId);
  Future<void> sendMessage(int bookingId, String content);
  Future<void> markAsRead(int bookingId);
  Future<void> disconnect();
}

/// Implementation of [ChatRemoteDataSource] that wraps [ChatSignalRService].
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ChatSignalRService service;

  const ChatRemoteDataSourceImpl({required this.service});

  @override
  Stream<ChatMessageEntity> get messageStream => service.messageStream;

  @override
  Stream<List<ChatMessageEntity>> get historyStream => service.historyStream;

  @override
  Stream<void> get seenStream => service.seenStream;

  @override
  Stream<BookingStatusEntity> get statusStream => service.statusStream;

  @override
  Stream<ChatConnectionState> get connectionStateStream =>
      service.connectionStateStream;

  @override
  Future<void> connect(int bookingId) => service.connect(bookingId);

  @override
  Future<void> sendMessage(int bookingId, String content) =>
      service.sendMessage(bookingId, content);

  @override
  Future<void> markAsRead(int bookingId) => service.markAsRead(bookingId);

  @override
  Future<void> disconnect() => service.dispose();
}
