import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class MoodItem extends StatelessWidget {
  final String emoji;
  final String text;
  final TextStyle? textStyle;

  const MoodItem(this.emoji, this.text, {super.key, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.whiteColor,
          child: Text(emoji, style: const TextStyle(fontSize: 25)),
        ),
        const SizedBox(height: 6),
        Text(text, style: textStyle ?? AppStyles.medium15Gray),
      ],
    );
  }
}
