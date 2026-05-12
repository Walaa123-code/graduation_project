import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../di/di.dart';
import '../manager/create_memory_cubit.dart';
import '../manager/delete_memory_cubit.dart';
import '../manager/delete_memory_state.dart';
import '../manager/memory_cubit.dart';
import '../manager/memory_state.dart';
import '../widgets/add_memory_screen.dart';

class MemoriesTab extends StatelessWidget {
  const MemoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<MemoryCubit>()..getMemory()),
        BlocProvider(create: (context) => getIt<DeleteMemoryCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteMemoryCubit, DeleteMemoryState>(
            listener: (context, state) {
              if (state is DeleteMemorySuccessState) {
                context.read<MemoryCubit>().getMemory();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Memory deleted successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state is DeleteMemoryErrorState) {
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
        child: BlocBuilder<MemoryCubit, MemoryState>(
          builder: (context, state) {
            // Loading
            if (state is GetMemoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                    color: AppColors.lavenderColor),
              );
            }

            // Error
            if (state is GetMemoryErrorState) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
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
                            context.read<MemoryCubit>().getMemory(),
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
            if (state is GetMemorySuccessState) {
              final memories =
                  state.getMemoryResponseEntity.data ?? [];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Header
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Happy Echoes",
                                style: AppStyles.bold23Black.copyWith(
                                    color: AppColors.lavenderColor),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Capture moments that light up your day",
                                style: AppStyles.medium16Gray,
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) =>
                                        getIt<CreateMemoryCubit>(),
                                    child: const AddMemoryScreen(),
                                  ),
                                ),
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<MemoryCubit>()
                                      .getMemory();
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.lavenderColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Grid or Empty
                    Expanded(
                      child: memories.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_album_outlined,
                                      size: 70,
                                      color: AppColors.gray300),
                                  SizedBox(height: 16),
                                  Text("No memories yet",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16)),
                                  SizedBox(height: 8),
                                  Text(
                                      "Tap the camera icon to add your first memory",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13)),
                                ],
                              ),
                            )
                          : GridView.builder(
                              physics:
                                  const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: memories.length,
                              itemBuilder: (context, index) {
                                final memory = memories[index];
                                return GestureDetector(
                                  onTap: () =>
                                      _showMemoryOptions(
                                          context, memory),
                                  onLongPress: () =>
                                      _showDeleteDialog(
                                          context, memory),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius
                                                    .vertical(
                                              top: Radius.circular(
                                                  20),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  memory.imageUrl ??
                                                      "",
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              placeholder: (context,
                                                      url) =>
                                                  Container(
                                                      color: AppColors
                                                          .gray200),
                                              errorWidget: (context,
                                                      url, error) =>
                                                  const Icon(Icons
                                                      .broken_image_outlined),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              memory.title ??
                                                  "Untitled",
                                              style:
                                                  AppStyles.bold16Black,
                                              maxLines: 1,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showMemoryOptions(BuildContext context, dynamic memory) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(memory.title ?? "Untitled",
                style: AppStyles.bold20Black),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Colors.red),
              title: const Text("Delete Memory"),
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
        title: const Text("Delete Memory"),
        content: Text(
          "Are you sure you want to delete '${memory.title ?? 'this memory'}'?",
          style: AppStyles.medium15Gray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Cancel", style: AppStyles.medium16Black),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<DeleteMemoryCubit>()
                  .deleteMemory(memory.id!.toInt());
            },
            child: Text("Delete",
                style: AppStyles.medium16Black
                    .copyWith(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
