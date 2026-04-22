import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Custom Primary Button Widget
/// Teal background with soft shadow, rounded corners, and smooth animations
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.padding,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: isOutlined
            ? null
            : AppTheme
                .shadowTeal, // TODO: Update shadow color based on background
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? AppColors.primary),
          foregroundColor: isOutlined
              ? (backgroundColor ?? AppColors.primary)
              : (textColor ?? AppColors.white),
          elevation: 0,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingXl,
                vertical: AppTheme.spacingMd,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            side: isOutlined
                ? const BorderSide(color: AppColors.primary, width: 2)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isOutlined ? AppColors.primary : AppColors.white,
                ),
              ),
      ),
    );
  }
}

/// Rounded Button for Navigation (Next, Skip, Get Started)
class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        boxShadow: isPrimary ? AppTheme.shadowTeal : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : AppColors.white,
          foregroundColor: isPrimary ? AppColors.white : AppColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXl,
            vertical: AppTheme.spacingSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPrimary ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
