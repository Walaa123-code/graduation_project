import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_styles.dart';
import '../manager/mood_cubit.dart';

class MoodItem extends StatelessWidget {
  final String emoji;
  final String label;
  final int id; // بنضيف الـ ID عشان نبعته للـ API

  const MoodItem({
    super.key,
    required this.emoji,
    required this.label,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // الـ Widget بتكلم الكيوبيت مباشرة أول ما تتداس
        context.read<MoodCubit>().selectMood(id);
      },
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppStyles.medium15Gray, // أو الستايل اللي تحبيه
            ),
          ],
        ),
      ),
    );
  }
}