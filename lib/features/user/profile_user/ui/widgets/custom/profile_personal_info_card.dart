import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class ProfilePersonalInfoCard extends StatelessWidget {
  final int? age;
  final int? gender;
  final String? id;

  const ProfilePersonalInfoCard({
    super.key,
    required this.age,
    required this.gender,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    String genderText = gender == 0 ? "Male" : "Female";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Info", style: AppStyles.bold16Black),
          const Divider(height: 20, thickness: 0.5),
          _buildInfoRow(Icons.cake_outlined, "Age", "${age ?? '--'} years old"),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.wc_outlined, "Gender", genderText),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.fingerprint_outlined, "User ID", id ?? "Not available", isId: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value, {bool isId = false}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.lavenderColor),
        const SizedBox(width: 10),
        Text("$title: ", style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: isId ? 12 : 14,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}