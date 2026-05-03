import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Account Type Card Widget
/// Selectable card for User/Doctor account type selection
class AccountTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final VoidCallback onTap;

  const AccountTypeCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gray200, width: 2),
          boxShadow: AppTheme.shadowSm,
        ),
        child: Column(
          children: [
            // Icon
            Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              child: icon,
            ),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.gray800,
              ),
            ),

            const SizedBox(height: AppTheme.spacingXs),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.gray500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
