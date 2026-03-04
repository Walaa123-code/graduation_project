import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return             TextField(
      style: TextStyle(color: AppColors.whiteColor),
      cursorColor: AppColors.grayColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.grayColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.grayColor,
            width: 1.5,
          ),
        ),
        prefixIcon: Icon(Icons.search, color: AppColors.blackColor,size: 22,),
        suffixIcon: Icon(Icons.clear, color: AppColors.blackColor,size: 22,),
        hintText: 'Search',
        hintStyle: AppStyles.medium17Gray,
      ),
      onChanged: (text){},
    )
    ;
  }
}
