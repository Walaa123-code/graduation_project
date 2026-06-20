import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../manager/journal_details_cubit.dart';

class JournalsDetails extends StatelessWidget {
  const JournalsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Journal Details",
          style: AppStyles.bold23Black,
        ),


        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: AppColors.lavenderColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<JournalDetailsCubit, JournalDetailsState>(
        builder: (context, state) {
          if (state is JournalDetailsLoadingState) {
            return const Center(
                child:
                    CircularProgressIndicator(color: AppColors.lavenderColor));
          } else if (state is JournalDetailsSuccessState) {
            final journal = state.getResponseDetEntity.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journal?.title ?? "No Title",
                    style: AppStyles.bold24Black,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        journal?.date ?? "No Date",
                        style: AppStyles.medium15Gray,
                      ),
                    ],
                  ),
                  const Divider(height: 40, thickness: 1),
                  Text(
                    journal?.content ?? "No Content available.",
                    style: AppStyles.medium16Black,
                  ),
                ],
              ),
            );
          } else if (state is JournalDetailsErrorState) {
            return Center(
              child: Text(
                state.failures.errors.toString(),
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }

          return const Center(
              child: Text("Select a journal to view its details."));
        },
      ),
    );
  }
}
