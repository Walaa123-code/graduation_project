import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class EmptySchedule extends StatelessWidget {
  const EmptySchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingXl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          const Icon(Icons.calendar_today, size: 48, color: AppColors.gray300),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            'No schedules set up yet',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
