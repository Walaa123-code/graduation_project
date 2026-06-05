import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class ChatBotWelcome extends StatelessWidget {
  const ChatBotWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lavenderColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_outlined,
                size: 50, color: AppColors.lavenderColor),
          ),
          const SizedBox(height: 16),
          Text("Hi! I'm MindEcho Bot 👋", style: AppStyles.bold20Black),
          const SizedBox(height: 8),
          Text(
            "I'm here to listen and support you.\nFeel free to share how you're feeling.",
            textAlign: TextAlign.center,
            style: AppStyles.medium16Gray,
          ),
        ],
      ),
    );
  }
}
