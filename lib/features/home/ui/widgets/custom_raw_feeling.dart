import 'package:flutter/material.dart';
import '../../../../core/utils/app_styles.dart';

class CustomRaw extends StatelessWidget {
  String text;
  String text1;
  String text2;
  String image;
  String image1;
  String image2;
  CustomRaw(
      {super.key,
      required this.text,
      required this.image,
      required this.text1,
      required this.text2,
      required this.image1,
      required this.image2});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
