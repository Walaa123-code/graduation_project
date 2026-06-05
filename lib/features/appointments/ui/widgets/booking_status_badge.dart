import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

class BookingStatusBadge extends StatelessWidget {
  final int status;

  const BookingStatusBadge({super.key, required this.status});

  static Map<String, dynamic> getStatus(int status) {
    switch (status) {
      case 0:
        return {'label': 'Pending', 'color': const Color(0xFFED8936)};
      case 1:
        return {'label': 'Confirmed', 'color': const Color(0xFF38A169)};
      case 2:
        return {'label': 'Cancelled', 'color': AppColors.red};
      case 3:
        return {'label': 'Completed', 'color': AppColors.lavenderColor};
      default:
        return {'label': 'Unknown', 'color': AppColors.gray400};
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = getStatus(status);
    final color = info['color'] as Color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        info['label'],
        style: TextStyle(
            color: color, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
