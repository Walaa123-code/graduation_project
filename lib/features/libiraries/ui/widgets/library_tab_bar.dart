import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

class LibraryTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const LibraryTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab("Podcast", 0,),
        const SizedBox(width: 10),
        _buildTab("Music", 1),
        const SizedBox(width: 10),
        _buildTab("Exercises", 2),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ?  AppColors.lavenderColor : AppColors.darkWhitColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
            fontWeight: FontWeight.w600,
            fontSize: isSelected ? 17 : 16,
          ),
        ),
      ),
    );
  }
}
