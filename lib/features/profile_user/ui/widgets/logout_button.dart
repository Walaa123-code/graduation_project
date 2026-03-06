import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_styles.dart';

import '../../../../core/utils/app_colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.logout, color: AppColors.red),
      label:  Text("Logout",
          style: AppStyles.medium16Red),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.red),
        padding: const EdgeInsets.all(14),
      ),
    );
  }
}
