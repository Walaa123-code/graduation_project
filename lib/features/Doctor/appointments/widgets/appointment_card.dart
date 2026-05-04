import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/appointment_item.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentItem appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, 3),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCardHeader(),
          const Divider(height: 1, color: AppColors.gray100),
          _buildCardDetails(),
          if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
            const Divider(height: 1, color: AppColors.gray100),
            _buildNotes(),
          ],
          const Divider(height: 1, color: AppColors.gray100),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: appointment.avatarColor.withValues(alpha: 0.15),
            child: Text(
              appointment.patientInitials,
              style: TextStyle(
                color: appointment.avatarColor,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name + duration
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.patientName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 13, color: AppColors.gray400),
                    const SizedBox(width: 3),
                    Text(
                      '${appointment.durationMinutes} minutes',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.gray400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Status badge
          _StatusBadge(
            label: appointment.statusLabel,
            color: appointment.statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingSm),
      child: Row(
        children: [
          _DetailChip(
            icon: Icons.calendar_today_outlined,
            label: appointment.date,
          ),
          const SizedBox(width: 10),
          _DetailChip(
            icon: Icons.access_time_rounded,
            label: appointment.time,
          ),
          const SizedBox(width: 10),
          _DetailChip(
            icon: appointment.sessionType == SessionType.online
                ? Icons.videocam_outlined
                : Icons.location_on_outlined,
            label: appointment.sessionTypeLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.notes_rounded, size: 15, color: AppColors.gray400),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              appointment.notes!,
              style: const TextStyle(fontSize: 13, color: AppColors.gray500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Row(
        children: [
          // Message button – outlined
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
              label: const Text('Message'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.purpleSoft,
                side: const BorderSide(color: AppColors.purpleSoft),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                padding: const EdgeInsets.symmetric(vertical: 11),
                textStyle:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Call button – gradient
          Expanded(
            child: _GradientButton(
              label: 'Call',
              icon: Icons.phone_outlined,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small reusable sub-widgets ──────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.gray400),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.gray600),
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9B7EBD), Color(0xFF5B6EE8)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: AppColors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
