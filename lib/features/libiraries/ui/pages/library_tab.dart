import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/chatbot/ui/pages/chatbot_screen.dart';
import 'package:mindecho/features/libiraries/ui/widgets/library_filter_row.dart';
import 'package:mindecho/features/libiraries/ui/widgets/library_search_bar.dart';

import '../manager/library_cubit.dart';
import '../widgets/library_grid.dart';

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
    _libraryCubit.getLibrary(widget.initialMood ?? 0);
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
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Library", style: AppStyles.bold26Black),
          ),
        ),
        floatingActionButton: Tooltip(
          message: "Chat with Bot",
          triggerMode: TooltipTriggerMode.longPress,
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatBotScreen()),
            ),
            backgroundColor: AppColors.lavenderColor,
            child: const Icon(Icons.smart_toy_outlined, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LibrarySearchBar(
                controller: _searchController,
                searchQuery: _searchQuery,
                onChanged: (v) =>
                    setState(() => _searchQuery = v.toLowerCase().trim()),
                onClear: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
              ),
              SizedBox(height: height * 0.02),
              LibraryFilterRow(
                selectedType: _selectedType,
                onChanged: (type) => setState(() => _selectedType = type),
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
                  child: LibraryGrid(
                libraryCubit: _libraryCubit,
                selectedType: _selectedType,
                searchQuery: _searchQuery,
                baseUrl: _baseUrl,
                initialMood: widget.initialMood,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
