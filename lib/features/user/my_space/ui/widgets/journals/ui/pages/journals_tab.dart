import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/di/di.dart';
import '../manager/delete_journal_cubit.dart';
import '../manager/journal_cubit.dart';
import '../manager/journal_details_cubit.dart';
import '../widgets/journal_build_header.dart';
import '../widgets/journals_details.dart';
import 'package:mindecho/features/user/my_space/ui/widgets/custom/space_item_card.dart';

class JournalsTab extends StatefulWidget {
  const JournalsTab({super.key});

  @override
  State<JournalsTab> createState() => _JournalsTabState();
}

class _JournalsTabState extends State<JournalsTab> {
  String friendlyErrorMessage(String error) {
    if (error.contains("not found")) return "Journal not found or already deleted.";
    return error;
  }

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
                final journalCubit = context.read<JournalCubit>();

                if (journalCubit.state is GetJournalSuccessState) {
                  final currentState = journalCubit.state as GetJournalSuccessState;

                  final currentList = currentState.getJournalResponseEntity.data ?? [];

                  journalCubit.getJournal();
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Journal deleted successfully"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              if (state is DeleteJournalErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(friendlyErrorMessage(state.failures.errors.toString())),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<JournalCubit, JournalState>(
          builder: (context, state) {
            if (state is GetJournalLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                    color: AppColors.lavenderColor),
              );
            }

            if (state is GetJournalErrorState) {
              return AppErrorWidget(
                message: state.failures.errors.toString(),
                onRetry: () => context.read<JournalCubit>().getJournal(),
                title: "Couldn't load journals",
                icon: Icons.book_outlined,
              );
            }

            if (state is GetJournalSuccessState) {
              final journals = state.getJournalResponseEntity.data ?? [];

              if (journals.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
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
                  ),
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
                      emoji: "📓",
                      isMemory: false,
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