import 'package:flutter/material.dart';
import 'package:mindecho/core/components/app_container.dart';
import 'package:mindecho/features/my_space/ui/widgets/space_item_card.dart';

import '../../../../core/utils/app_colors.dart';


class MemoriesTab extends StatelessWidget {
  const MemoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children:  [
        AppContainer(title: "Memory World",iconData: Icons.memory_rounded,iconColor: AppColors.whiteColor,

            subtitle: "Capture your best emotional moments", buttonText: "Add Memory"),
        SizedBox(height: 16),
        SpaceItemCard(
          title: "First Achievement",
          subtitle: "Completed my first big milestone",
          emoji: "✨",
        ),
        SpaceItemCard(
          title: "Family Gathering",
          subtitle: "A warm and happy day together",
          emoji: "💛",
        ),
      ],
    );
  }
}
