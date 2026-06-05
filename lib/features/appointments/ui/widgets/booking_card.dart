import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/appointments/domain/entities/BookingDataEntity.dart';
import 'package:mindecho/features/appointments/ui/widgets/booking_info_chip.dart';
import 'package:mindecho/features/appointments/ui/widgets/booking_status_badge.dart';
import 'package:mindecho/features/chat/ui/pages/chat_screen.dart';

class BookingCard extends StatelessWidget {
  final BookingDataEntity booking;
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
  final BookingDataEntity booking;
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
          _DoctorAvatar(),
          const SizedBox(width: 14),
          Expanded(child: _SessionInfo(booking: booking)),
          BookingStatusBadge(status: booking.bookingStatus?.toInt() ?? 0),
        ],
      ),
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.lavenderColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person_outline,
          color: AppColors.lavenderColor, size: 28),
    );
  }
}

class _SessionInfo extends StatelessWidget {
  final BookingDataEntity booking;
  const _SessionInfo({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Session #${booking.doctorSessionSlotId ?? '-'}",
            style: AppStyles.bold18Black),
        const SizedBox(height: 3),
        Text(
          "Doctor: ${_shortId(booking.doctorId)}",
          style: AppStyles.medium15Gray,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _shortId(String? id) {
    if (id == null || id.length < 8) return id ?? '-';
    return '${id.substring(0, 8)}...';
  }
}

// --- Details ---
class _CardDetails extends StatelessWidget {
  final BookingDataEntity booking;
  final VoidCallback onCancel;
  const _CardDetails({required this.booking, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              BookingInfoChip(
                icon: Icons.access_time_outlined,
                label: "Requested",
                value: _formatDate(booking.requestedAt),
                color: AppColors.gray400,
              ),
              if (booking.confirmedAt != null) ...[
                const SizedBox(width: 12),
                BookingInfoChip(
                  icon: Icons.check_circle_outline,
                  label: "Confirmed",
                  value: _formatDate(booking.confirmedAt),
                  color: Colors.green,
                ),
              ],
            ],
          ),
          if (booking.bookingStatus == 0) ...[
            const SizedBox(height: 14),
            _CancelButton(onCancel: onCancel),
          ],

          // زرار الـ chat لو Confirmed
          if (booking.bookingStatus == 1) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      bookingId: booking.id!.toInt(),
                      doctorId: booking.doctorId ?? '',
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
