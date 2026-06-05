import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../manager/library_cubit.dart';
import 'library_card.dart';
import 'library_item_bottom_sheet.dart';

class LibraryGrid extends StatelessWidget {
  final LibraryCubit libraryCubit;
  final int? selectedType;
  final String searchQuery;
  final String baseUrl;
  final int? initialMood;

  const LibraryGrid({super.key,
    required this.libraryCubit,
    required this.selectedType,
    required this.searchQuery,
    required this.baseUrl,
    required this.initialMood,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        if (state is LibraryLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.lavenderColor),
          );
        }

        if (state is LibraryErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off_rounded,
                    size: 70, color: Colors.grey),
                const SizedBox(height: 16),
                Text("Connection Problem", style: AppStyles.bold20Black),
                const SizedBox(height: 8),
                Text(state.failures.errors,
                    textAlign: TextAlign.center, style: AppStyles.medium17Gray),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => libraryCubit.getLibrary(initialMood ?? 0),
                  icon: const Icon(Icons.refresh),
                  label: const Text("Try Again"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lavenderColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is LibrarySuccessState) {
          var items = state.libraryResponseEntity.data ?? [];

          if (selectedType != null) {
            items = items.where((e) => e.type == selectedType).toList();
          }
          if (searchQuery.isNotEmpty) {
            items = items
                .where(
                    (e) => (e.title ?? '').toLowerCase().contains(searchQuery))
                .toList();
          }

          if (items.isEmpty) {
            return Center(
                child: Text("No items found", style: AppStyles.medium17Gray));
          }

          return GridView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => LibraryItemBottomSheet.show(context, item),
                child: LibraryCard(item: item, baseUrl: baseUrl),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
