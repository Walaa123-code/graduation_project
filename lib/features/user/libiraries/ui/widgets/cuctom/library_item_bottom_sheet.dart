import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../../../domain/entities/LibraryDateEntity.dart';

class LibraryItemBottomSheet extends StatelessWidget {
  final LibraryDataEntity item;

  const LibraryItemBottomSheet({super.key, required this.item});

  static void show(BuildContext context, LibraryDataEntity item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => LibraryItemBottomSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title ?? "No Title", style: AppStyles.bold20Black),
          const SizedBox(height: 8),
          Text(
            item.type == 0 ? "Music • Podcast" : "Article • Read",
            style: const TextStyle(
                color: AppColors.lavenderColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          if (item.contentUrl != null)
            Text("URL: ${item.contentUrl}", style: AppStyles.medium17Gray),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lavenderColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                item.type == 0 ? "Play Now" : "Read Now",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
