import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import '../manager/create_journal_cubit.dart';
import '../manager/journal_cubit.dart';
import 'add_journal_screen.dart';

class JournalBuildHeader extends StatelessWidget {
  const JournalBuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Previous Journals", style: AppStyles.bold20Black),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.lavenderColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) => getIt<CreateJournalCubit>(),
                            child: const AddJournalScreen(),
                          ),
                        ),
                      );
                      if (!context.mounted) return;

                      context.read<JournalCubit>().getJournal();
                    },
                    child: Row(
                      children: [
                        Text("New", style: AppStyles.bold18Lavender),
                      ],
                    ),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
