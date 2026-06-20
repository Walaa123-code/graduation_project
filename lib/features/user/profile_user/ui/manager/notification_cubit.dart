import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_changed_entity.dart';
import 'package:mindecho/features/user/profile_user/data/services/notification_signalr_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationSignalRService _signalRService =
      NotificationSignalRService();
  final List<BookingStatusChangedEntity> _notifications = [];
  bool _hasUnread = false;

  NotificationCubit() : super(NotificationInitialState());

  void init() {
    _setupSignalR();
  }

  void _setupSignalR() async {
    try {
      _signalRService.onBookingStatusChanged = (bookingStatus) {
        _notifications.insert(0, bookingStatus);
        _hasUnread = true;
        emit(NotificationUpdatedState(
          notifications: List.from(_notifications),
          hasUnread: _hasUnread,
        ));
      };

      await _signalRService.connect();
    } catch (e) {
      debugPrint("Failed to connect to SignalR notifications: $e");
    }
  }

  void markAllAsRead() {
    _hasUnread = false;
    emit(NotificationUpdatedState(
      notifications: List.from(_notifications),
      hasUnread: _hasUnread,
    ));
  }

  void clearNotifications() {
    _notifications.clear();
    _hasUnread = false;
    emit(NotificationUpdatedState(
      notifications: List.from(_notifications),
      hasUnread: _hasUnread,
    ));
  }

  List<BookingStatusChangedEntity> get notifications =>
      List.from(_notifications);
  bool get hasUnread => _hasUnread;

  @override
  Future<void> close() async {
    await _signalRService.disconnect();
    return super.close();
  }
}
