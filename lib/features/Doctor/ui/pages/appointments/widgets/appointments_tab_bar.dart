import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class AppointmentsTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const AppointmentsTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  static const List<String> _labels = [
    'Upcoming Appointments',
    'Schedule',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingSm),
      child: Row(
        children: List.generate(_labels.length, (i) {
          final isActive = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: i == 0 ? 8 : 0),
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  gradient: isActive

                ? const LinearGradient(
                          colors: [Color(0xFF6B3FA0), Color(0xFF9643B6), Color(0xFFD4B5F0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                      : null,
                  color: isActive ? null : AppColors.gray100,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppColors.white : AppColors.gray500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
