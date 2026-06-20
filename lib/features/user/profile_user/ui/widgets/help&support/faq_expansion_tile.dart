import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

class FaqExpansionTile extends StatelessWidget {
  final String question;
  final String answer;

  const FaqExpansionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.lavenderColor,
          collapsedIconColor: Colors.grey,
          title: Text(
            question,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                answer,
                style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}