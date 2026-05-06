import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class MemoryFormWidget extends StatelessWidget {
  final TextEditingController titleController;
  final String actionText;
  final VoidCallback onAction;

  const MemoryFormWidget({
    super.key,
    required this.titleController,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$actionText Memory", style: AppStyles.bold20Lavender),
          const SizedBox(height: 15),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Enter Title",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.lavenderColor),
            child: Text(actionText, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}