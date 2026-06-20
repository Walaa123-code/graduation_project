import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

/// هيدر تاب الـ Memories - العنوان + زرار الإضافة
class MemoriesHeader extends StatelessWidget {
  final VoidCallback onAddTap;

  const MemoriesHeader({super.key, required this.onAddTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Happy Echoes',
                style: AppStyles.bold23Black
                    .copyWith(color: AppColors.lavenderColor),
              ),
              const SizedBox(height: 3),
              Text(
                'Capture moments that light up your day',
                style: AppStyles.medium16Gray,
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onAddTap,
            borderRadius: BorderRadius.circular(30),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.add_a_photo_outlined,
                color: AppColors.lavenderColor,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
