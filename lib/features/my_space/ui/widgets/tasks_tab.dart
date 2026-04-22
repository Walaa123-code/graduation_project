import 'package:flutter/material.dart';
import 'package:mindecho/features/my_space/ui/widgets/task_item_card.dart';
import '../../../../core/utils/app_styles.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        TaskItemCard(
          title: "Deep Breathing",
          subtitle: "5 minutes breathing exercise",
          titleStyle: AppStyles.bold20Black,
          subTitleStyle: AppStyles.medium15Gray,
        ),
        TaskItemCard(
          title: "Write Journal",
          subtitle: "Write your thoughts today",
          titleStyle: AppStyles.bold20Black,
          subTitleStyle: AppStyles.medium15Gray,
        ),
        TaskItemCard(
          title: "Yoga Session",
          subtitle: "15 minutes session",
          titleStyle: AppStyles.bold20Black,
          subTitleStyle: AppStyles.medium15Gray,
        ),
      ],
    );
  }
}
