import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import '../widgets/journals_tab.dart';
import '../widgets/memories_tab.dart';
import '../widgets/tasks_tab.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffF6F7FB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Space",
                style: AppStyles.bold25Black,
              ),
              Container(
                decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(25),border:Border.all(color: AppColors.lavenderColor, width: 1.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Contact with therapist", style: AppStyles.bold18Lavender,),
                ),
              )
            ],
          ),
          bottom:  const TabBar(
            indicatorColor: AppColors.lavenderColor,
            labelColor: AppColors.lavenderColor,
            unselectedLabelColor: AppColors.blackColor,

            tabs: [
              Tab(text: "Journals",),
              Tab(text: "Memories"),
              // Tab(text: "Tasks"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            JournalsTab(),
            MemoriesTab(),
          ],
        ),
      ),
    );
  }
}







