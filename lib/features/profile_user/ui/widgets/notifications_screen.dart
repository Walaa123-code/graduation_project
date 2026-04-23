import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'notifications_cards.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          toolbarHeight: 75,
          title: Text(
            "Notifications",
            style: AppStyles.bold24Black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              NotificationsCard(
                title: "Motivation Message",
                subtitle: "Keep going — you are doing great!",
                isNew: true,
                icon: Icons.favorite,
                onTap: () {},
              ),
              NotificationsCard(
                title: "Reminder",
                subtitle: "Don't forget today's exercise",
                isNew: false,
                icon: Icons.calendar_today,
                onTap: () {},
              ),
              NotificationsCard(
                title: "From Doctor",
                subtitle: "How are you feeling today?",
                isNew: true,
                icon: Icons.chat_bubble,
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
