import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class LibraryEmptyHint extends StatelessWidget {
  const LibraryEmptyHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.mood, size: 60, color: AppColors.lavenderColor),
          const SizedBox(height: 12),
          Text(
            "Select your mood to get\npersonalized recommendations",
            textAlign: TextAlign.center,
            style: AppStyles.medium17Gray,
          ),
        ],
      ),
    );
  }
}
