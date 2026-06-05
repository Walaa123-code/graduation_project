import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

import '../../../../core/utils/app_styles.dart';

class BookingFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BookingFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lavenderColor
              : AppColors.lavenderColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: isSelected ? AppStyles.bold18Whit : AppStyles.bold16Lavender,
        ),
      ),
    );
  }
}
