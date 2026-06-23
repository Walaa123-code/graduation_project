import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';

class EmptyConversations extends StatelessWidget {
  final bool hasSearch;
  const EmptyConversations({super.key, required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.purpleBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48,
              color: AppColors.purpleSoft,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            hasSearch ? 'No results found' : 'No conversations yet',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasSearch
                ? 'Try a different search'
                : 'Confirmed bookings will appear here',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.gray500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}