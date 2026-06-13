import 'package:mindecho/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:mindecho/features/chat/domain/repositories/chat_repository.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';


/// Concrete implementation of [ChatRepository].
///
/// Acts as a thin delegation layer — all work is done in
/// [ChatRemoteDataSource].
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  const ChatRepositoryImpl({required this.remoteDataSource});

  // ── Streams ────────────────────────────────────────────────────

  @override
  Stream<ChatMessageEntity> get messageStream => remoteDataSource.messageStream;

  @override
  Stream<List<ChatMessageEntity>> get historyStream => remoteDataSource.historyStream;

  @override
  Stream<void> get seenStream => remoteDataSource.seenStream;

  @override
  Stream<BookingStatusEntity> get statusStream => remoteDataSource.statusStream;

  @override
  Stream<ChatConnectionState> get connectionStateStream =>
      remoteDataSource.connectionStateStream;

  // ── Invocations ────────────────────────────────────────────────

  @override
  Future<void> connect(int bookingId) => remoteDataSource.connect(bookingId);

  @override
  Future<void> sendMessage(int bookingId, String content) =>
      remoteDataSource.sendMessage(bookingId, content);

  @override
  Future<void> markAsRead(int bookingId) => remoteDataSource.markAsRead(bookingId);

  @override
  Future<void> disconnect() => remoteDataSource.disconnect();
}
