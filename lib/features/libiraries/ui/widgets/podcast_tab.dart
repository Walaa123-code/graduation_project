import 'package:flutter/material.dart';
import '../../../../core/components/app_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class PodcastTab extends StatelessWidget {
  const PodcastTab({super.key});

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
                      "Inner Peace Journey",
                      style: AppStyles.bold20Black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Dr. Ahmed Mahmoud",
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
                    "25 min",
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
                      "Dealing With Anger",
                      style: AppStyles.bold20Black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Dr. Sarah Ahmed",
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
                    "18 min",
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
