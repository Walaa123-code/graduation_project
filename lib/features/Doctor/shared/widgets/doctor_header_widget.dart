import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class DoctorHeaderWidget extends StatelessWidget {
  final String doctorName;
  final String greeting;
  final String imageUrl;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;

  const DoctorHeaderWidget({
    super.key,
    required this.doctorName,
    required this.greeting,
    required this.imageUrl, // In a real app this might be a URL or asset path
    required this.onNotificationTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.purpleSoft, // Fallback color
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF9C27B0), // Deep Purple, approximating the design
            Color(0xFF7B1FA2),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onProfileTap,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage:
                            AssetImage(imageUrl), // Or NetworkImage
                        onBackgroundImageError: (_, __) =>
                            const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                        ),
                        Text(
                          doctorName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.white),
                  ),
                ],
              ),
              // Optional: Add date display here if needed matching the design
            ],
          ),
        ),
      ),
    );
  }
}
