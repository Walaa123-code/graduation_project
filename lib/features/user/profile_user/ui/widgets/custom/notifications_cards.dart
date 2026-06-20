import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? doctorName;
  final bool isNew;

  const NotificationCard({
    required this.title,
    required this.subtitle,
    this.doctorName,
    required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isNew ? AppColors.purpleBg : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isNew
            ? Border.all(color: AppColors.lavenderColor.withValues(alpha: 0.3))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lavenderColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.lavenderColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppStyles.bold16Black,
                      ),
                    ),
                    if (isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "NEW",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AppStyles.medium14Gray),
                if (doctorName != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Dr. $doctorName',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.lavenderColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}