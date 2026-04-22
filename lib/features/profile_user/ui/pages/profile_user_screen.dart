import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/profile_user/ui/widgets/profile_header.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_item_tile.dart';
import '../widgets/state_card.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: Column(
        children: [
          ProfileHeader(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    "7",
                    "Session",
                    labelStyle: AppStyles.medium14DarkGray,
                    valueStyle: AppStyles.bold17Lavender,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: StatCard(
                  "28",
                  "Exercises",
                  labelStyle: AppStyles.medium14DarkGray,
                  valueStyle: AppStyles.bold17Lavender,
                )),
                SizedBox(width: 10),
                Expanded(
                    child: StatCard(
                  "14",
                  "Days",
                  labelStyle: AppStyles.medium14DarkGray,
                  valueStyle: AppStyles.bold17Lavender,
                )),
              ],
            ),
          ),

          const SizedBox(height: 5),

          /// settings list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfileItemTile(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  titleStyle: AppStyles.medium16Black,
                ),
                ProfileItemTile(
                  icon: Icons.settings_outlined,
                  title: "Settings",
                  titleStyle: AppStyles.medium16Black,
                ),
                ProfileItemTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Dark Mode",
                  titleStyle: AppStyles.medium16Black,
                ),
                ProfileItemTile(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  titleStyle: AppStyles.medium16Black,
                ),
                SizedBox(height: 12),
                LogoutButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
