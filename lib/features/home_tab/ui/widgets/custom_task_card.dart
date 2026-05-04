import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomTaskCard extends StatelessWidget {
  final String text;
  final IconData icon;
  const CustomTaskCard({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkWhitColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Icon(
           icon ,
              size: 60,
              color: AppColors.blueColor,
            ),
            Text(
              text,
              style: AppStyles.bold20DarkBlue,
            )
          ],
        ),
      ),
    );
  }
}
