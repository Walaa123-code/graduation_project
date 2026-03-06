import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import 'notifications_cards.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF6F7FB),
        appBar: AppBar(
            title: const Text("Notifications"),
            flexibleSpace:
            Container(decoration: BoxDecoration(
                color: AppColors.lavenderColor
              // gradient:
              // AppColors.lavenderColor)
            ),
            )),
        body: ListView(
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
        )


    );
  }
}
