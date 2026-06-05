import 'package:flutter/material.dart';
import 'package:mindecho/core/components/custom_text_field.dart';

class LibrarySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const LibrarySearchBar({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: 'Search',
      prefixIcon: const Icon(Icons.search, color: Colors.black54, size: 22),
      suffixIcon: searchQuery.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear, color: Colors.black54, size: 20),
              onPressed: onClear,
            )
          : null,
      onChanged: onChanged,
    );
  }
}
