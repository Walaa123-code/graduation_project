import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class TaskItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  const TaskItemCard({
    super.key,
    required this.title,
    required this.subtitle, required this.titleStyle, required this.subTitleStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 4,
        child: CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: Text(title, style: titleStyle,),
          subtitle: Text(subtitle,style: subTitleStyle,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tileColor: AppColors.darkWhitColor,
          controlAffinity: ListTileControlAffinity.trailing,
        ),
      ),
    );
  }
}
