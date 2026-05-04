import 'package:flutter/material.dart';
import 'package:mindecho/core/components/app_card.dart';



class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  const StatCard(this.value, this.label,{super.key, required this.labelStyle, required this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return AppCard(child: Column(
      children: [
        Text(value,
            style: valueStyle),
        const SizedBox(height: 4),
        Text(label,
            style: labelStyle),
      ],
    ),);

  }
}
