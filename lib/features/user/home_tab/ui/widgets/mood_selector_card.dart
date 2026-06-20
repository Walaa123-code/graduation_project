import 'package:flutter/material.dart';
import 'package:mindecho/core/components/app_card.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'mood_item.dart';

class MoodSelectorCard extends StatelessWidget {
  const MoodSelectorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderRadius: 20,
      elevation: 3,
      color: AppColors.grayShad1Color,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MoodItem(emoji: "😊", label: "Happy", id: 1),
                MoodItem(emoji: "😨", label: "Scared", id: 2),
                MoodItem(emoji: "😕", label: "Sad", id: 3),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MoodItem(emoji: "😐", label: "Neutral", id: 4),
                MoodItem(emoji: "😡", label: "Angry", id: 5),
                MoodItem(emoji: "😯", label: "Surprised", id: 6),
                MoodItem(emoji: "🤢", label: "Disgusted", id: 7),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
