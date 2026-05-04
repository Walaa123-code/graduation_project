import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/my_space/ui/widgets/space_item_card.dart';

import '../../../../../di/di.dart';
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
    return BlocProvider(
      create: (context) => getIt<JournalCubit>()..getJournal(),
      child: BlocBuilder<JournalCubit, JournalState>(
        builder: (context, state) {
          if (state is GetJournalLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetJournalErrorState) {
            return Text(state.failures.errors.toString());
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
                  // onTap: () {
                  //   // 1. نادي الـ API
                  //   context
                  //       .read<JournalDetailsCubit>()
                  //       .getJournalById(journal.id!.toInt());
                  // 2. روحي لصفحة التفاصيل مع تمرير الـ Cubit
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          // هنا بنكريت الكوبيت ونخليه ينادي الدالة فوراً بالـ ID
                          create: (context) => getIt<JournalDetailsCubit>()
                            ..getJournalById(journal.id!.toInt()),
                          child: const JournalsDetails(),
                        ),
                      ),
                    );
                  },
                  child: SpaceItemCard(
                    journal: journal, // السطر ده مهم جداً عشان التعديل والمسح
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
    );
  }
}
