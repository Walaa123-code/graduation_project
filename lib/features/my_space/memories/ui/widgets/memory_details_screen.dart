import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../di/di.dart';
import '../manager/memory_details_cubit.dart';
import '../manager/update_memory_cubit.dart';
import '../manager/update_memory_state.dart';
import 'memory_form_sheet.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final int memoryId;
  const MemoryDetailsScreen({super.key, required this.memoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemoryDetailsCubit>()..getMemoryById(memoryId),
      child: Scaffold(
        appBar: AppBar(title: const Text("Memory Details")),
        body: BlocBuilder<MemoryDetailsCubit, MemoryDetailsState>(
          builder: (context, state) {
            if (state is MemoryDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MemoryDetailsSuccessState) {
              final memory = state.getMemoryDetResponseEntity.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(memory?.title ?? "", style: AppStyles.bold20Lavender),
                    const SizedBox(height: 10),
                    Text(memory?.moodState ?? "", style: AppStyles.medium15Black),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _showEditBottomSheet(context, memory),
                      child: const Text("Update This Memory"),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text("Error loading details"));
          },
        ),
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context, dynamic memory) {
    final titleController = TextEditingController(text: memory.title);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => BlocProvider(
        create: (context) => getIt<UpdateMemoryCubit>(),
        child: BlocConsumer<UpdateMemoryCubit, UpdateMemoryState>(
          listener: (context, state) {
            if (state is UpdateMemorySuccessState) {
              Navigator.pop(ctx); // قفل الشيت
              context.read<MemoryDetailsCubit>().getMemoryById(memoryId); // تحديث التفاصيل
            }
          },
          builder: (context, state) {
            return MemoryFormWidget(
              titleController: titleController,
              actionText: "Update",
              onAction: () {
                context.read<UpdateMemoryCubit>().updateMemory(
                  memoryId,
                  titleController.text,
                  memory.moodState,
                  "new_image_url",
                );
              },
            );
          },
        ),
      ),
    );
  }
}