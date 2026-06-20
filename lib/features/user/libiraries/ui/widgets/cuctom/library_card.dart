import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../../../domain/entities/LibraryDateEntity.dart';

class LibraryCard extends StatelessWidget {
  final LibraryDataEntity item;
  final String baseUrl;

  const LibraryCard({
    super.key,
    required this.item,
    required this.baseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                "$baseUrl${item.imageUrl}",
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.lavenderColor.withOpacity(0.1),
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

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? "No Title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.bold16Black.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      item.type == 0 ? Icons.headphones : Icons.article,
                      size: 13,
                      color: AppColors.lavenderColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.type == 0 ? "Music • Podcast" : "Article • Read",
                      style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
