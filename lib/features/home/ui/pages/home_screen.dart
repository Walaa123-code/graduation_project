import 'package:flutter/material.dart';
import 'package:graduation_project/core/components/custom_elevated_button.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_container.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_raw_feeling.dart';
import 'package:graduation_project/features/home/ui/widgets/custom_task_card.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.lavenderColor,
        toolbarHeight: 220,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.menu_outlined,
                  size: 28,
                  color: AppColors.darkBlueColor,
                ),
                Icon(
                  Icons.notifications_none,
                  size: 28,
                  color: AppColors.darkBlueColor,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text("Welcome Back, Alex", style: AppStyles.bold25DarkBlue),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Tell us how you’re feeling so ew can tailor\n your experience.",
              style: AppStyles.medium16Gray,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text("How are you feeling right now?",
                style: AppStyles.bold22DarkBlue),
          ],
        ),
      ),
      body: Stack(children: [
        CustomContainer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                color: AppColors.darkWhitColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CustomRaw(
                        text: "Happy",
                        image: AssetsManager.happyImage,
                        text1: "Neutral",
                        image1: AssetsManager.happyImage,
                        text2: "Fear",
                        image2: AssetsManager.happyImage,
                      ),
                      CustomRaw(
                        text: "Anger",
                        image: AssetsManager.happyImage,
                        text1: "Joy",
                        image1: AssetsManager.happyImage,
                        text2: "Sad",
                        image2: AssetsManager.happyImage,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: SizedBox(
                  height: 55,
                  child: CustomElevatedButton(
                    textButton: "Doctor’s Recommendation",
                    textStyle: AppStyles.bold20Whit,
                    backGroundColor: AppColors.darkBlueColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Self Care Today",
                style: AppStyles.bold22DarkBlue,
              ),
              Text("Your daily space to reflect and grow.",
                  style: AppStyles.medium16Gray),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTaskCard(
                    text: " Daily Journal ",
                    icon: Icons.edit_note,
                  ),
                  CustomTaskCard(
                    text: "  Daily Tasks  ",
                    icon: Icons.task,
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTaskCard(
                    text: "My Memories ",
                    icon: Icons.edit_note,
                  ),
                  CustomTaskCard(
                    text: "  Daily Tasks  ",
                    icon: Icons.task,
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
