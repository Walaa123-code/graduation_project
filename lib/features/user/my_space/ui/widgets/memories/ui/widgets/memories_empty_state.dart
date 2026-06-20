import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

/// شاشة الـ empty state لما مفيش memories
class MemoriesEmptyState extends StatelessWidget {
  const MemoriesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_album_outlined,
              size: 70, color: AppColors.gray300),
          SizedBox(height: 16),
          Text(
            'No memories yet',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the camera icon to add your first memory',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
