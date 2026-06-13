import 'package:flutter/material.dart';

enum AppointmentStatus { confirmed, pending, cancelled }

enum SessionType { online, inPerson }

class AppointmentItem {
  final String patientName;
  final String patientInitials;
  final Color avatarColor;
  final AppointmentStatus status;
  final int durationMinutes;
  final String date;
  final String time;
  final SessionType sessionType;
  final String? notes;

  const AppointmentItem({
    required this.patientName,
    required this.patientInitials,
    required this.avatarColor,
    required this.status,
    required this.durationMinutes,
    required this.date,
    required this.time,
    required this.sessionType,
    this.notes,
  });

  String get statusLabel {
    switch (status) {
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case AppointmentStatus.confirmed:
        return const Color(0xFF48BB78);
      case AppointmentStatus.pending:
        return const Color(0xFFFFB84D);
      case AppointmentStatus.cancelled:
        return const Color(0xFFFC8181);
    }
  }

  String get sessionTypeLabel => sessionType == SessionType.online
      ? 'Online Session'
      : 'In-Person Session';
}
