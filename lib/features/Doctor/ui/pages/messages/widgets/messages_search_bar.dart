import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class MessagesSearchBar extends StatelessWidget {
  const MessagesSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: AppTheme.shadowSm,
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Search conversations...',
            hintStyle: const TextStyle(color: AppColors.gray400, fontSize: 14),
            prefixIcon:
                const Icon(Icons.search, color: AppColors.gray400, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingMd,
            ),
          ),
        ),
      ),
    );
  }
}
