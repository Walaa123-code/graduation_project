import 'package:mindecho/core/api/api_constants.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_changed_entity.dart';
import 'package:signalr_netcore/signalr_client.dart';

/// Service منفصل للإشعارات فقط - لا يتعارض مع ChatSignalRService
class NotificationSignalRService {
  HubConnection? _connection;
  bool _isConnected = false;

  // Callback للإشعارات فقط
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

    // يسمع فقط لـ BookingStatusChanged
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

  Future<void> disconnect() async {
    await _connection?.stop();
    _isConnected = false;
  }
}
