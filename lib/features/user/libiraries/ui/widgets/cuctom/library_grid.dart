import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../../manager/library_cubit.dart';
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
          return AppErrorWidget(
            message: state.failures.errors.toString(),
            onRetry: () => libraryCubit.getLibrary(initialMood ?? 0),
            title: "Couldn't load library",
            icon: Icons.menu_book_outlined,
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
