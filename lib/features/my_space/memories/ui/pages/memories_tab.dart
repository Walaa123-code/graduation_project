import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../di/di.dart';
import '../manager/create_memory_cubit.dart';
import '../manager/delete_memory_cubit.dart';
import '../manager/memory_cubit.dart';
import '../manager/memory_state.dart';
import '../widgets/add_memory_screen.dart';

class MemoriesTab extends StatelessWidget {
  const MemoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MemoryCubit>()..getMemory()),
        BlocProvider(create: (context) => getIt<DeleteMemoryCubit>()),
      ],
      child: BlocBuilder<MemoryCubit, MemoryState>(
        builder: (context, state) {
          if (state is GetMemoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMemorySuccessState) {
            final memories = state.getMemoryResponseEntity.data ?? [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Happy Echoes",
                              style: AppStyles.bold23Black.copyWith(
                                color: AppColors.lavenderColor,
                              ),
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
                            debugPrint("Navigating to Add Memory Screen...");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => getIt<CreateMemoryCubit>(), // توفير الكيوبيت باستخدام GetIt
                                  child: const AddMemoryScreen(),
                                ),
                              ),
                            );                          },
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
                  Expanded(
                    child: memories.isEmpty
                        ? const Center(child: Text("No memories yet. Click the icon to add!"))
                        : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: memories.length,
                      itemBuilder: (context, index) {
                        final memory = memories[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: memory.imageUrl ?? "",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(color: AppColors.gray200),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    memory.title ?? "Untitled",
                                    style: AppStyles.bold16Black,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetMemoryErrorState) {
            return Center(child: Text(state.failures.errors ?? "Error loading memories"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}