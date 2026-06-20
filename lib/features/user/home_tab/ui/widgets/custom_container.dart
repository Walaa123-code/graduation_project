import 'package:flutter/material.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return         Container(
      height: 130,
      decoration: const BoxDecoration(
        color: AppColors.lavenderColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    )
    ;
  }
}
