import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class DoctorAvatarWidget extends StatelessWidget {
  const DoctorAvatarWidget({
    super.key,
    required this.profilePicture,
    required this.fullName,
    required this.onTap,
  });

  final String? profilePicture;
  final String fullName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.purpleBg,
            backgroundImage:
                profilePicture != null && profilePicture!.isNotEmpty
                    ? NetworkImage(profilePicture!)
                    : null,
            child: profilePicture == null || profilePicture!.isEmpty
                ? Text(
                    fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.purpleSoft,
                    ),
                  )
                : null,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
