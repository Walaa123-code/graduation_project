import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class PatientsEmptyState extends StatelessWidget {
  const PatientsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: AppColors.gray300),
          SizedBox(height: AppTheme.spacingMd),
          Text(
            'No patients yet',
            style: TextStyle(color: AppColors.gray500),
          ),
        ],
      ),
    );
  }
}
