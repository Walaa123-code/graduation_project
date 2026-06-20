import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 55, bottom: 30, left: 20, right: 20),
      decoration: const BoxDecoration(
        gradient: AppColors.gradient,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            backgroundImage: (imageUrl != null && imageUrl!.startsWith('http'))
                ? NetworkImage(imageUrl!)
                : null,
            child: (imageUrl != null && imageUrl!.startsWith('http'))
                ? null
                : const Icon(Icons.person, size: 40, color: Colors.grey),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isEmpty ? "User Name" : userName,
                  style: AppStyles.bold22Whit,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail.isEmpty ? "user@example.com" : userEmail,
                  style: AppStyles.medium18DarkGray.copyWith(
                    color: Colors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}