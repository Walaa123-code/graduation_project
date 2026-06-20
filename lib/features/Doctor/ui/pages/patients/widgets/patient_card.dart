import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});

  final dynamic patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white,
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
        contentPadding: const EdgeInsets.all(AppTheme.spacingMd),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.purpleBg,
          child: Text(
            patient.fullName.isNotEmpty
                ? patient.fullName[0].toUpperCase()
                : '?',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.purpleSoft,
            ),
          ),
        ),
        title: Text(
          patient.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.gray800,
          ),
        ),
        subtitle: Text(
          patient.email ?? 'No email',
          style: const TextStyle(color: AppColors.gray500, fontSize: 13),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.gray400,
        ),
      ),
    );
  }
}
