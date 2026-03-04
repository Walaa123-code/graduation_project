import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';

class ExerciseCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;

  const ExerciseCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lavenderColor,
            AppColors.blueColor,
          ],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.self_improvement,
            color: Colors.white,
            size: 35,
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyles.bold20Whit),
                SizedBox(height: height * 0.01),
                Text(description, style: AppStyles.medium14White),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.play_arrow, color: Colors.white, size: 30),
              SizedBox(height: height * 0.01),
              Text(duration, style: AppStyles.medium14White),
            ],
          ),
        ],
      ),
    );
  }
}
