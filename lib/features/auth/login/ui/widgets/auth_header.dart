import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import 'package:mindecho/core/utils/app_colors.dart';

/// Header مشترك للـ auth screens (title + subtitle)
class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color titleColor;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.titleColor = AppColors.gray800,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: titleColor,
            letterSpacing: -0.5,
          ),
        ),
        if (subtitle != null) ...[
          Text(
            subtitle!,
            style: const TextStyle(fontSize: 16, color: AppColors.gray500),
          ),
        ],
      ],
    );
  }
}
