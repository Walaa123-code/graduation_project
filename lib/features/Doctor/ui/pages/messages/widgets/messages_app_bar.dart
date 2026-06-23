// ملف مستقل: lib/features/Doctor/ui/pages/messages/widgets/messages_app_bar.dart
import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        'Messages',
        style: TextStyle(
          color: AppColors.gray800,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune_rounded, color: AppColors.gray600),
          onPressed: () {},
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: ColoredBox(
          color: AppColors.gray100,
          child: SizedBox(height: 1, width: double.infinity),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}