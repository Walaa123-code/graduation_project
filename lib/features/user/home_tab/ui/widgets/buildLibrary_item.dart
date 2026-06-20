import 'package:flutter/material.dart';

import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class BuildLibraryItem extends StatelessWidget {
  const BuildLibraryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayShad1Color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lavenderColor.withOpacity(0.09),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 45, color: AppColors.lavenderColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Podcast Title", style: AppStyles.bold16Black),
                const SizedBox(height: 4),
                Text("15 Minutes", style: AppStyles.medium15Gray),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
