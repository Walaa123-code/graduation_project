import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class ScheduleTileCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String dayLabel;
  final dynamic slotId;
  final bool isActive;

  const ScheduleTileCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.dayLabel,
    required this.slotId,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEEE6FF), Color(0xFFE0E8FF)],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppColors.purpleLight),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: AppColors.purpleSoft, size: 20),
          const SizedBox(width: 8),
          Text(
            '$dayLabel  $startTime – $endTime',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.purpleSoft,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.gray200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isActive ? 'Active' : 'Off',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.primary : AppColors.gray500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
