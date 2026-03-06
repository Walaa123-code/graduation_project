import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class NotificationsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isNew;
  final IconData icon;
  final VoidCallback? onTap;


  const NotificationsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isNew,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.blue.withOpacity(.1),
                child: Icon(icon, color: AppColors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                        if (isNew)
                          Container(
                            margin:
                            const EdgeInsets.only(left: 8),
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "NEW",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
