import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
class LibraryRecommendationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int type;
  final VoidCallback onTap;

  const LibraryRecommendationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.lavenderColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 45,
                      color: AppColors.lavenderColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.bold16Black.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            type == 0 ? "Music • Podcast" : "Article • Read",
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
