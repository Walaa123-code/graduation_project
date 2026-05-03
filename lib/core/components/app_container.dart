import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/components/custom_elevated_button.dart';

class AppContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final Color? iconColor;
  const AppContainer({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onPressed,
    this.iconData, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lavenderColor,
            AppColors.blueColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconData, color: iconColor,),
                SizedBox(width: width * 0.02),
                Text(
                  title,
                  style: AppStyles.bold20Whit,
                ),
              ],
            ),
            SizedBox(height: height * 0.004),
            Text(
              subtitle,
              style: AppStyles.medium16White,
            ),
            SizedBox(height: height * 0.02),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomElevatedButton(
                  textButton: buttonText,
                  textStyle: AppStyles.bold17Lavender,
                  backGroundColor: AppColors.whiteColor,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
