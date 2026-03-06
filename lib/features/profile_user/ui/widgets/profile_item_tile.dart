import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class ProfileItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextStyle titleStyle;

  const ProfileItemTile({
    super.key,
    required this.icon,
    required this.title, required this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.lavenderColor.withOpacity(.1),
          child: Icon(icon, color: AppColors.lavenderColor),
        ),
        title: Text(title, style: titleStyle,),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
