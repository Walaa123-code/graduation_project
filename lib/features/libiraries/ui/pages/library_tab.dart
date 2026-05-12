import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/libiraries/domain/entities/LibraryDateEntity.dart';
import 'package:mindecho/features/libiraries/ui/manager/library_cubit.dart';
import 'package:mindecho/features/libiraries/ui/widgets/library_card.dart';

class LibraryTab extends StatefulWidget {
  final int? initialMood;
  const LibraryTab({super.key, this.initialMood});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  final LibraryCubit _libraryCubit = getIt<LibraryCubit>();
  final String _baseUrl = "https://10.0.2.2:7200";
  final TextEditingController _searchController = TextEditingController();

  int? _selectedType;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final mood = widget.initialMood ?? 0;
    _libraryCubit.getLibrary(mood);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _libraryCubit,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text("Library", style: AppStyles.bold26Black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                cursorColor: AppColors.grayColor,
                onChanged: (value) =>
                    setState(() => _searchQuery = value.toLowerCase().trim()),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: AppColors.grayColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: AppColors.lavenderColor, width: 1.5),
                  ),
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.black54, size: 22),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear,
                              color: Colors.black54, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  hintText: 'Search',
                  hintStyle: AppStyles.medium17Gray,
                ),
              ),

              SizedBox(height: height * 0.02),

              Row(
                children: [
                  Expanded(child: _buildFilterChip("All", null)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildFilterChip("Podcast", 0)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildFilterChip("Articles", 1)),
                ],
              ),

              SizedBox(height: height * 0.02),

              Text(
                widget.initialMood != null
                    ? "Recommended for your mood"
                    : "All Library",
                style: AppStyles.bold20Black,
              ),

              SizedBox(height: height * 0.02),

              Expanded(
                child: BlocBuilder<LibraryCubit, LibraryState>(
                  builder: (context, state) {
                    if (state is LibraryLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.lavenderColor),
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
                            Text("Connection Problem",
                                style: AppStyles.bold20Black),
                            const SizedBox(height: 8),
                            Text(state.failures.errors,
                                textAlign: TextAlign.center,
                                style: AppStyles.medium17Gray),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => _libraryCubit
                                  .getLibrary(widget.initialMood ?? 0),
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
                      final allItems = state.libraryResponseEntity.data ?? [];

                      var items = _selectedType == null
                          ? allItems
                          : allItems
                              .where((e) => e.type == _selectedType)
                              .toList();

                      if (_searchQuery.isNotEmpty) {
                        items = items
                            .where((e) => (e.title ?? '')
                                .toLowerCase()
                                .contains(_searchQuery))
                            .toList();
                      }

                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            "No items found",
                            style: AppStyles.medium17Gray,
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () => _openItem(context, item),
                            child: LibraryCard(
                              item: item,
                              baseUrl: _baseUrl,
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int? type) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lavenderColor
              : AppColors.lavenderColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: isSelected? AppStyles.bold18Whit: AppStyles.bold16Lavender

        ),
      ),
    );
  }

  void _openItem(BuildContext context, LibraryDataEntity item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
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
      ),
    );
  }
}
