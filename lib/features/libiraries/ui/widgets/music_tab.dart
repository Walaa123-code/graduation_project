import 'package:flutter/material.dart';

import '../../../../core/components/app_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class MusicTab extends StatelessWidget {
  const MusicTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nature Sounds",
                      style: AppStyles.bold20Black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Relaxation",
                      style: AppStyles.medium15Gray,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.play_circle_fill,
                    color: AppColors.lavenderColor,
                    size: 33,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "45 min",
                    style: AppStyles.medium15Gray,
                  ),
                ],
              ),
            ],
          ),
        ),
        AppCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deep Sleep Music",
                      style: AppStyles.bold20Black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Calm Vibes",
                      style: AppStyles.medium15Gray,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.play_circle_fill,
                    color: AppColors.lavenderColor,
                    size: 33,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "60 min",
                    style: AppStyles.medium15Gray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
