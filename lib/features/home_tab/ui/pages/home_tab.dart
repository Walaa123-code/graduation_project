import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import '../../../../core/components/app_card.dart';
import '../../../../core/components/app_container.dart';
import '../widgets/action_card.dart';
import '../widgets/mood_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: AppColors.grayShad1Color,
        title: Column(
          children: [
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello, Alex",
                  style: AppStyles.bold25Black,
                ),
                Icon(
                  Icons.notifications_none,
                  size: 28,
                )
              ],
            ),
            SizedBox(height: height * 0.01),

            Row(
              children: [
                Text("How are you feeling Today, Alex?",
                    style: AppStyles.medium17Gray),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Text("Choose your mood", style: AppStyles.bold21Black),
                ],
              ),
              SizedBox(height: height * 0.01),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: height * 0.02,
                ),
                child: AppCard(
                  borderRadius: 20,
                  elevation: 4,
                  color: AppColors.grayShad1Color,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MoodItem("😊", "Happy"),
                          MoodItem("😨", "Scared"),
                          MoodItem("😕", "Sad"),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MoodItem("😐", "Neutral"),
                          MoodItem("😡", "Angry"),
                          MoodItem("😯", "Surprised"),
                          MoodItem("🤢", "Disgusted"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        icon: Icons.self_improvement,
                        title: "My space",
                        subtitle: "Memories, Tasks",
                        color: AppColors.lavenderColor,
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.menu_book,
                        title: "Library",
                        subtitle: "Podcast, Exercise",
                        color: AppColors.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height*0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppContainer(
                  iconData: Icons.group,
                  iconColor: AppColors.whiteColor,
                  title: "Community Sessions",
                  subtitle: "Join safe and supportive group sessions",
                  buttonText: "Join now",
                  onPressed: () {
                  },
                ),
              ),

              SizedBox(height: height*0.02),
            ],
          ),
        ),
      ),
    );
  }
}


