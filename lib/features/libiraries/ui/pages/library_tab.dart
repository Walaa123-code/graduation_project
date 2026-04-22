import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../widgets/exercise_tab.dart';
import '../widgets/library_tab_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/music_tab.dart';
import '../widgets/podcast_tab.dart';

class LibraryTab extends StatefulWidget {
  const LibraryTab({super.key});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Library",
            style: AppStyles.bold26Black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(),
            SizedBox(height: height * 0.02),
            LibraryTabBar(
              selectedIndex: selectedIndex,
              onTabChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Text(
                  "Recommended library for you",
                  style: AppStyles.bold20Black,
                )
              ],
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  PodcastTab(),
                  MusicTab(),
                  ExerciseTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }






}
