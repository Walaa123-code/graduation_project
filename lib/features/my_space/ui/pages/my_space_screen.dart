import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../di/di.dart';
import '../../memories/ui/pages/memories_tab.dart';
import '../../journals/ui/manager/delete_journal_cubit.dart';
import '../../journals/ui/manager/journal_cubit.dart';
import '../../journals/ui/pages/journals_tab.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => getIt<JournalCubit>()..getJournal()),
          BlocProvider(create: (context) => getIt<DeleteJournalCubit>()),
        ],
        child: Scaffold(
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: AppColors.lavenderColor, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Contact with therapist",
                      style: AppStyles.bold18Lavender,
                    ),
                  ),
                )
              ],
            ),
            bottom: TabBar(
              labelStyle: AppStyles.bold18Lavender,
              unselectedLabelStyle: AppStyles.bold16Black,
              indicatorColor: AppColors.lavenderColor,
              labelColor: AppColors.lavenderColor,
              unselectedLabelColor: AppColors.blackColor,
              tabs: const [
                Tab(
                  text: "Journals",
                ),
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
      ),
    );
  }
}
