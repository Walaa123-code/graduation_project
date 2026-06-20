import 'package:flutter/material.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          SizedBox(
            height: AppTheme.spacingMd,
          ),
          Text(
            'Connecting to chat…',
          ),
        ],
      ),
    );
  }
}