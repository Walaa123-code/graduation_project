import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

class ContactSupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailingText;
  final VoidCallback onTap;

  const ContactSupportCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: AppColors.lavenderColor.withValues(alpha: .1),
          child: Icon(icon, color: AppColors.lavenderColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF0EFFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            trailingText,
            style: const TextStyle(color: AppColors.lavenderColor, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}