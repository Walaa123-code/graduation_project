import 'package:flutter/material.dart';


class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,  this.textButton,
        required this.textStyle, required this.backGroundColor, VoidCallback? onPressed});
  final String? textButton;
  final TextStyle textStyle;
  final Color backGroundColor;
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
