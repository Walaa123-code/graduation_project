import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class CustomRaw extends StatelessWidget {
  final String text;
  final String text1;
  final String text2;
  final String image;
  final String image1;
  final String image2;
  const CustomRaw(
      {super.key,
      required this.text,
      required this.image,
      required this.text1,
      required this.text2,
      required this.image1,
      required this.image2});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Card(
              child: Column(
            children: [
              Image.asset(
                image,
                height: 65,
                width: 80,
              ),

              Text(
                text,
                style: AppStyles.bold15DarkBlue,
              )
            ],
          )),
        ),
        Card(
            child: Column(
          children: [
            Image.asset(
              image1,
              height: 65,
              width: 80,
            ),

            Text(
              text1,
              style: AppStyles.bold15DarkBlue,
            )
          ],
        )),
        Card(
            child: Column(
          children: [
            Image.asset(
              image2,
              height: 65,
              width: 80,
            ),

            Text(
              text2,
              style: AppStyles.bold15DarkBlue,
            )
          ],
        )),
      ],
    );
  }
}
