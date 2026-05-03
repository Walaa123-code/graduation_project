import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Page Indicator Dots for Onboarding
/// Active dot: 24px width, teal color
/// Inactive dots: 8px circles, gray
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: currentPage == index ? 24 : 8,
          height: 8,
          margin:
              const EdgeInsets.symmetric(horizontal: AppTheme.spacingXs / 2),
          decoration: BoxDecoration(
            color: currentPage == index ? AppColors.primary : AppColors.gray300,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          ),
        ),
      ),
    );
  }
}
