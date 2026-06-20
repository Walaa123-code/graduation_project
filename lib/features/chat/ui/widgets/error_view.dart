import 'package:flutter/material.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppTheme.spacingXl,
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 56,
              color: AppColors.gray300,
            ),
            const SizedBox(
              height: AppTheme.spacingMd,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppTheme.spacingLg,
            ),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}