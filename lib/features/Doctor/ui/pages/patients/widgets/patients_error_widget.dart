import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class PatientsErrorWidget extends StatelessWidget {
  const PatientsErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.gray400,
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.gray600),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
