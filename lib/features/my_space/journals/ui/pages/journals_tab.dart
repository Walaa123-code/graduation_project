import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/my_space/memories/ui/manager/delete_memory_cubit.dart';
import 'package:mindecho/features/my_space/ui/widgets/space_item_card.dart';

import '../../../../../di/di.dart';
import '../../../memories/ui/manager/delete_memory_state.dart';
import '../manager/journal_cubit.dart';
import '../manager/journal_details_cubit.dart';
import '../widgets/journal_build_header.dart';
import '../widgets/journals_details.dart';

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
            create: (context) => getIt<DeleteMemoryCubit>(),
          ),
        ],
        child: BlocListener<DeleteMemoryCubit, DeleteMemoryState>(
          listener: (context, state) {
            if (state is DeleteMemorySuccessState) {
              context.read<JournalCubit>().getJournal();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Deleted Successfully")),
              );
            }
          },
          child: BlocBuilder<JournalCubit, JournalState>(
            builder: (context, state) {
              if (state is GetJournalLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetJournalErrorState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_off_rounded,
                            size: 75, color: AppColors.gray300),
                        const SizedBox(height: 20),
                        Text(
                          "Connection Problem",
                          style: AppStyles.bold20Black,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.failures
                              .errors, // الرسالة اللي جاية من الـ _handleError في الـ DataSource
                          textAlign: TextAlign.center,
                          style: AppStyles.medium16DarkGray,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<JournalCubit>().getJournal();
                          },
                          icon: const Icon(Icons.refresh),
                          label: Text(
                            "Try Again",
                            style: AppStyles.bold20Whit,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // Text(state.failures.errors.toString());
              } else if (state is GetJournalSuccessState) {
                final journals = state.getJournalResponseEntity.data ?? [];
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: journals.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const JournalBuildHeader();
                    }

                    final journal = journals[index - 1];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (context) => getIt<JournalDetailsCubit>()
                                ..getJournalById(journal.id!.toInt()),
                              child: const JournalsDetails(),
                            ),
                          ),
                        );
                      },
                      child: SpaceItemCard(
                        itemData: journal,
                        title: journal.title ?? "No Title",
                        subtitle: journal.content ?? "No Content",
                        emoji: "😊",
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
