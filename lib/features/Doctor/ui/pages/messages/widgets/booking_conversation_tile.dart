import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import '../../../../../user/appointments/domain/entities/booking_entity.dart';

class BookingConversationTile extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback onTap;

  const BookingConversationTile({
    super.key,
    required this.booking,
    required this.onTap,
  });

  String get _patientInitials {
    final id = booking.userId;
    return id.length >= 2
        ? id.substring(0, 2).toUpperCase()
        : id.toUpperCase();
  }

  String get _patientName =>
      'Patient #${booking.userId.length > 6 ? booking.userId.substring(0, 6) : booking.userId}';

  String get _subtitle => 'Session #${booking.doctorSessionSlotId} • Tap to chat';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.purpleBg,
          child: Text(
            _patientInitials,
            style: const TextStyle(
              color: AppColors.purpleSoft,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        title: Text(
          _patientName,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.gray800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            _subtitle,
            style: const TextStyle(fontSize: 13, color: AppColors.gray500),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.purpleBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Confirmed',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.purpleSoft,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}