import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,  this.textButton,
        required this.textStyle, required this.backGroundColor, VoidCallback? onPressed});
  String? textButton;
  TextStyle textStyle;
  Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(

        backgroundColor: backGroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), ),
      child: Text(
        textButton!,
        style: textStyle,
      ),
    );
  }
}
