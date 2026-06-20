import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: AppTheme.spacingXl),
        Text(
          'Join Us as a Doctor',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.gray800,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: AppTheme.spacingSm),
        Text(
          'Create your doctor account and start helping patients',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.gray500,
          ),
        ),
        SizedBox(height: AppTheme.spacingXl),
      ],
    );
  }
}
