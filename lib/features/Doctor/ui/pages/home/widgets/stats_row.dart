import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/widgets/stats_card.dart';

/// A row of three stats cards: Specialty, Schedules, and Patients.
class StatsRow extends StatelessWidget {
  final String specialization;
  final int scheduleCount;
  final int patientCount;

  const StatsRow({
    super.key,
    required this.specialization,
    required this.scheduleCount,
    required this.patientCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            label: 'Specialty',
            value: specialization.isNotEmpty ? specialization : '—',
            icon: Icons.medical_services_outlined,
            color: AppColors.purpleSoft,
          ),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: StatsCard(
            label: 'Schedules',
            value: '$scheduleCount',
            icon: Icons.calendar_today,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: StatsCard(
            label: 'Patients',
            value: '$patientCount',
            icon: Icons.person_outline,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
