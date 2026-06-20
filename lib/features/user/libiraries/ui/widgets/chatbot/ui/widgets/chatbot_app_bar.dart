import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class ChatBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBotAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.lavenderColor),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.lavenderColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_outlined,
                color: AppColors.lavenderColor, size: 22),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("MindEcho Bot", style: AppStyles.bold18Black),
              Text("Always here for you",
                  style: AppStyles.medium15Gray.copyWith(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
