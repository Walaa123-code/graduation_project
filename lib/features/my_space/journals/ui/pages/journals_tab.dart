import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../di/di.dart';
import '../manager/delete_journal_cubit.dart';
import '../manager/journal_cubit.dart';
import '../manager/journal_details_cubit.dart';
import '../widgets/journal_build_header.dart';
import '../widgets/journals_details.dart';
import '../../../ui/widgets/space_item_card.dart';

class JournalsTab extends StatefulWidget {
  const JournalsTab({super.key});

  @override
  State<JournalsTab> createState() => _JournalsTabState();
}

class _JournalsTabState extends State<JournalsTab> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<JournalCubit>()..getJournal(),
        ),
        BlocProvider(
          create: (context) => getIt<DeleteJournalCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteJournalCubit, DeleteJournalState>(
            listener: (context, state) {
              if (state is DeleteJournalSuccessState) {
                context.read<JournalCubit>().getJournal();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Journal deleted successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state is DeleteJournalErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failures.errors),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<JournalCubit, JournalState>(
          builder: (context, state) {
            // Loading
            if (state is GetJournalLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                    color: AppColors.lavenderColor),
              );
            }

            // Error
            if (state is GetJournalErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off_rounded,
                          size: 75, color: AppColors.gray300),
                      const SizedBox(height: 20),
                      Text("Connection Problem",
                          style: AppStyles.bold20Black),
                      const SizedBox(height: 10),
                      Text(
                        state.failures.errors,
                        textAlign: TextAlign.center,
                        style: AppStyles.medium16DarkGray,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<JournalCubit>().getJournal(),
                        icon: const Icon(Icons.refresh,
                            color: Colors.white),
                        label: Text("Try Again",
                            style: AppStyles.bold20Whit),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lavenderColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Success
            if (state is GetJournalSuccessState) {
              final journals =
                  state.getJournalResponseEntity.data ?? [];

              if (journals.isEmpty) {
                return  const Column(
                  children: [
                    JournalBuildHeader(),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book_outlined,
                                size: 70, color: AppColors.gray300),
                            SizedBox(height: 16),
                            Text("No journals yet",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            SizedBox(height: 8),
                            Text("Tap 'New' to write your first journal",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: journals.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return const JournalBuildHeader();

                  final journal = journals[index - 1];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) =>
                                getIt<JournalDetailsCubit>()
                                  ..getJournalById(
                                      journal.id!.toInt()),
                            child: const JournalsDetails(),
                          ),
                        ),
                      );
                    },
                    child: SpaceItemCard(
                      itemData: journal,
                      title: journal.title ?? "No Title",
                      subtitle: journal.content ?? "No Content",
                      emoji: "📓",
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
