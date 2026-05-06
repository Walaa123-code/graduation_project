import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_container.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/my_space/ui/widgets/space_item_card.dart';

import '../../../../../core/utils/app_colors.dart';
import '../manager/memory_cubit.dart';
import '../manager/memory_state.dart';

class MemoriesTab extends StatelessWidget {
  const MemoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemoryCubit>()..getMemory(),
      child: BlocBuilder<MemoryCubit, MemoryState>(
        builder: (context, state) {
          if (state is GetMemoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMemorySuccessState) {
            final memories = state.getMemoryResponseEntity.data ?? [];

            if (memories.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: AppContainer(
                  title: "Memory World",
                  iconData: Icons.memory_rounded,
                  iconColor: AppColors.whiteColor,
                  subtitle: "No memories yet. Start capturing!",
                  buttonText: "Add Memory",
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount:
                  memories.length + 1, // +1 عشان الـ AppContainer يكون أول عنصر
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const AppContainer(
                    title: "Memory World",
                    iconData: Icons.memory_rounded,
                    iconColor: AppColors.whiteColor,
                    subtitle: "Capture your best emotional moments",
                    buttonText: "Add Memory",
                  );
                }

                final memory = memories[index - 1];
                return SpaceItemCard(
                  title: memory.title ?? "No Title",
                  subtitle: memory.moodState ?? "",
                  emoji: "✨",
                  itemData: memory,
                  isMemory: true,
                );
              },
            );
          } else if (state is GetMemoryErrorState) {
            return Center(
              child: Text(
                state.failures.errors ?? "Unexpected Error",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
