import 'package:flutter/material.dart';

class MessageItem {
  final String patientName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String initials;
  final Color avatarColor;

  /// The booking ID used to open the SignalR chat room.
  /// Nullable for backwards-compatibility with the static list.
  final int? bookingId;

  const MessageItem({
    required this.patientName,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.initials,
    required this.avatarColor,
    this.bookingId,
  });
}
