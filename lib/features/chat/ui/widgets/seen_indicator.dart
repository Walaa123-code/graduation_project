import 'package:flutter/material.dart';

import 'package:mindecho/core/theme/app_colors.dart';

class SeenIndicator extends StatelessWidget {
  const SeenIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        right: 8,
        top: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.done_all_rounded,
            size: 14,
            color: AppColors.primary,
          ),
          SizedBox(width: 4),
          Text(
            'Seen',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}