import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/chat/ui/pages/chat_screen.dart';
import '../../domain/entities/booking_entity.dart';
import 'booking_info_chip.dart';
import 'booking_status_badge.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback onCancel;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDefault,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _CardHeader(booking: booking),
          _CardDetails(booking: booking, onCancel: onCancel),
        ],
      ),
    );
  }
}

// --- Header ---
class _CardHeader extends StatelessWidget {
  final BookingEntity booking;
  const _CardHeader({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lavenderColor.withValues(alpha: 0.08),
            AppColors.purpleBg,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          _DoctorAvatar(profilePicture: booking.doctor?.profilePicture),
          const SizedBox(width: 14),
          Expanded(child: _SessionInfo(booking: booking)),
          BookingStatusBadge(status: booking.bookingStatus),
        ],
      ),
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  final String? profilePicture;
  const _DoctorAvatar({this.profilePicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.lavenderColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        image: profilePicture != null && profilePicture!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(profilePicture!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: profilePicture == null || profilePicture!.isEmpty
          ? const Icon(Icons.person_outline,
              color: AppColors.lavenderColor, size: 28)
          : null,
    );
  }
}

class _SessionInfo extends StatelessWidget {
  final BookingEntity booking;
  const _SessionInfo({required this.booking});

  String get _doctorName => booking.doctor?.fullName ?? 'Dr. ${booking.doctorId.substring(0, 8)}...';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Session #${booking.doctorSessionSlotId}",
            style: AppStyles.bold18Black),
        const SizedBox(height: 3),
        Text(
          _doctorName,
          style: AppStyles.medium15Gray,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (booking.doctor?.specialization != null) ...[
          const SizedBox(height: 2),
          Text(
            booking.doctor!.specialization!,
            style: AppStyles.medium14Gray,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

// --- Details ---
class _CardDetails extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback onCancel;
  const _CardDetails({required this.booking, required this.onCancel});

  String get _doctorName => booking.doctor?.fullName ?? 'Dr. ${booking.doctorId.length > 8 ? booking.doctorId.substring(0, 8) : booking.doctorId}...';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: BookingInfoChip(
                  icon: Icons.access_time_outlined,
                  label: "Requested",
                  value: _formatDate(booking.requestedAt),
                  color: AppColors.gray400,
                ),
              ),
              if (booking.confirmedAt != null) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: BookingInfoChip(
                    icon: Icons.check_circle_outline,
                    label: "Confirmed",
                    value: _formatDate(booking.confirmedAt),
                    color: Colors.green,
                  ),
                ),
              ],
            ],
          ),
          // Cancel button for Pending
          if (booking.bookingStatus == 0) ...[
            const SizedBox(height: 14),
            _CancelButton(onCancel: onCancel),
          ],

          // Chat button for Confirmed
          if (booking.bookingStatus == 1) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      bookingId: booking.id,
                      doctorId: booking.doctorId,
                      chatPartnerName: _doctorName,
                      currentUserSenderType: 0,
                    ),
                  ),
                ),
                icon: const Icon(Icons.chat_bubble_outline,
                    color: Colors.white, size: 18),
                label: const Text("Chat with Doctor",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lavenderColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final d = DateTime.parse(date);
      if (d.year < 2000) return 'N/A';
      return "${d.day}/${d.month}/${d.year}";
    } catch (_) {
      return 'N/A';
    }
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onCancel;
  const _CancelButton({required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onCancel,
        icon: const Icon(Icons.cancel_outlined, color: AppColors.red, size: 18),
        label: Text("Cancel Booking", style: AppStyles.medium16Red),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.red, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
