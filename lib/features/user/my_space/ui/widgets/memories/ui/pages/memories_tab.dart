import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/di/di.dart';
import '../manager/create_memory_cubit.dart';
import '../manager/delete_memory_cubit.dart';
import '../manager/delete_memory_state.dart';
import '../manager/memory_cubit.dart';
import '../manager/memory_state.dart';
import '../widgets/add_memory_screen.dart';
import '../widgets/memories_empty_state.dart';
import '../widgets/memories_header.dart';
import '../widgets/memory_card.dart';

class MemoriesTab extends StatelessWidget {
  const MemoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 شيلنا الـ MultiBlocProvider من هنا عشان رفعناه فوق في الـ MySpaceScreen
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteMemoryCubit, DeleteMemoryState>(
          listener: (context, state) {
            if (state is DeleteMemorySuccessState) {
              context.read<MemoryCubit>().getMemory();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Memory deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is DeleteMemoryErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(friendlyErrorMessage(state.failures.errors.toString())),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<MemoryCubit, MemoryState>(
        builder: (context, state) {
          if (state is GetMemoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.lavenderColor),
            );
          }

          if (state is GetMemoryErrorState) {
            return AppErrorWidget(
              message: state.failures.errors.toString(),
              onRetry: () => context.read<MemoryCubit>().getMemory(),
              title: "Couldn't load memories",
              icon: Icons.photo_album_outlined,
            );
          }

          if (state is GetMemorySuccessState) {
            final memories = state.getMemoryResponseEntity.data ?? [];

            // 🔥 تم استخدام CustomScrollView مع Slivers لحل مشكلة الـ Infinite Height تماماً جوه الـ TabBarView
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: MemoriesHeader(
                      onAddTap: () => _openAddMemory(context),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  memories.isEmpty
                      ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: MemoriesEmptyState()),
                  )
                      : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final memory = memories[index];
                        return MemoryCard(
                          memory: memory,
                          onTap: () => _showMemoryOptions(context, memory),
                          onLongPress: () => _showDeleteDialog(context, memory),
                        );
                      },
                      childCount: memories.length,
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // باقي الميثودز (_openAddMemory, _showMemoryOptions, _showDeleteDialog) تفضل زي ما هي تحت...
  void _openAddMemory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider(
          create: (_) => getIt<CreateMemoryCubit>(),
          child: const AddMemoryScreen(),
        ),
      ),
    ).then((_) {
      if (context.mounted) context.read<MemoryCubit>().getMemory();
    });
  }

  void _showMemoryOptions(BuildContext context, dynamic memory) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(memory.title ?? 'Untitled',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            ListTile(
              leading:
                  const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete Memory'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteDialog(context, memory);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, dynamic memory) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Memory'),
        content: Text(
          "Are you sure you want to delete '${memory.title ?? 'this memory'}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<DeleteMemoryCubit>()
                  .deleteMemory(memory.id!.toInt());
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
