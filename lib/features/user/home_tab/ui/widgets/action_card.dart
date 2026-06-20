import 'package:flutter/material.dart';

import 'package:mindecho/core/components/app_card.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.titleStyle,
    this.subTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return AppCard(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withValues(alpha: .15),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          SizedBox(height: height * 0.012),
          Text(
            title,
            style: titleStyle ?? AppStyles.bold18Black,
          ),
          SizedBox(height: height * 0.003),
          Text(
            subtitle,
            style: subTitleStyle ?? AppStyles.medium15Gray,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
