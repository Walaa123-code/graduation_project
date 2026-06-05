import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class LibraryFilterRow extends StatelessWidget {
  final int? selectedType;
  final ValueChanged<int?> onChanged;

  const LibraryFilterRow({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _chip("All", null)),
        const SizedBox(width: 8),
        Expanded(child: _chip("Podcast", 0)),
        const SizedBox(width: 8),
        Expanded(child: _chip("Articles", 1)),
      ],
    );
  }

  Widget _chip(String label, int? type) {
    final isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lavenderColor
              : AppColors.lavenderColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: isSelected
              ? AppStyles.bold18Whit
              : AppStyles.bold16Lavender,
        ),
      ),
    );
  }
}
