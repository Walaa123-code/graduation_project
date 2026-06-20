import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class LibraryErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const LibraryErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off_rounded, size: 75, color: AppColors.gray300),
          const SizedBox(height: 16),
          Text("Connection Problem", style: AppStyles.bold20Black),
          const SizedBox(height: 8),
          Text(message,
              textAlign: TextAlign.center, style: AppStyles.medium17Gray),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text("Try Again"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lavenderColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
