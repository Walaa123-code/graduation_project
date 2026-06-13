part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitialState extends NotificationState {}

final class NotificationUpdatedState extends NotificationState {
  final List<BookingStatusChangedEntity> notifications;
  final bool hasUnread;

  NotificationUpdatedState({
    required this.notifications,
    required this.hasUnread,
  });
}
