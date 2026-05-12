import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../di/di.dart';
import '../../../../core/components/app_card.dart';
import '../../../libiraries/ui/manager/library_cubit.dart';
import '../../../libiraries/ui/pages/library_tab.dart';
import '../manager/mood_cubit.dart';
import '../widgets/mood_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final MoodCubit _moodCubit = getIt<MoodCubit>();
  final LibraryCubit _libraryCubit = getIt<LibraryCubit>();
  final String _baseUrl = "https://10.0.2.2:7200";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _moodCubit),
        BlocProvider.value(value: _libraryCubit),
      ],
      child: BlocListener<MoodCubit, MoodState>(
        listener: (context, state) {
          if (state is MoodErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(child: Text(state.failures.errors,style: AppStyles.medium16White,)),
              backgroundColor: Colors.red,
            ));
          }
          if (state is MoodSuccessState) {
            final moodType =
                state.moodResponseEntity.data?.moodType?.toInt() ?? 1;
            _libraryCubit.getLibrary(moodType);
          }
        },
        child: BlocBuilder<MoodCubit, MoodState>(
          buildWhen: (prev, curr) =>
              curr is MoodInitialState ||
              curr is MoodLoadingState ||
              curr is MoodSuccessState ||
              curr is MoodErrorState,
          builder: (context, moodState) {
            final bool moodSelected = moodState is MoodSuccessState;

            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: AppBar(
                toolbarHeight: 85,
                backgroundColor: AppColors.grayShad1Color,
                elevation: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello, Alex", style: AppStyles.bold25Black),
                        const Icon(Icons.notifications_none, size: 28),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Text("How are you feeling Today, Alex?",
                        style: AppStyles.medium17Gray),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (moodState is MoodLoadingState)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: LinearProgressIndicator(
                          minHeight: 2,
                          backgroundColor: Colors.transparent,
                          color: AppColors.lavenderColor,
                        ),
                      ),

                    Text("Choose your mood", style: AppStyles.bold21Black),
                    SizedBox(height: height * 0.015),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: height * 0.008),
                      child: AppCard(
                        borderRadius: 20,
                        elevation: 3,
                        color: AppColors.grayShad1Color,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MoodItem(emoji: "😊", label: "Happy", id: 1),
                                  MoodItem(emoji: "😨", label: "Scared", id: 2),
                                  MoodItem(emoji: "😕", label: "Sad", id: 3),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MoodItem(
                                      emoji: "😐", label: "Neutral", id: 4),
                                  MoodItem(emoji: "😡", label: "Angry", id: 5),
                                  MoodItem(
                                      emoji: "😯",
                                      label: "Surprised",
                                      id: 6),
                                  MoodItem(
                                      emoji: "🤢",
                                      label: "Disgusted",
                                      id: 7),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        moodSelected
                            ? "Recommended for your mood"
                            : "Recommended Library",
                        style: AppStyles.bold21Black,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    Expanded(
                      child: BlocBuilder<LibraryCubit, LibraryState>(
                        builder: (context, libraryState) {
                          if (!moodSelected &&
                              libraryState is LibraryInitialState) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.mood,
                                      size: 60,
                                      color: AppColors.lavenderColor),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Select your mood to get\npersonalized recommendations",
                                    textAlign: TextAlign.center,
                                    style: AppStyles.medium17Gray,
                                  ),
                                ],
                              ),
                            );
                          }

                          if (libraryState is LibraryLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.lavenderColor),
                            );
                          }

                          if (libraryState is LibraryErrorState) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.cloud_off_rounded,
                                      size: 60, color: Colors.grey),
                                  const SizedBox(height: 12),
                                  Text(libraryState.failures.errors,
                                      textAlign: TextAlign.center,
                                      style: AppStyles.medium17Gray),
                                ],
                              ),
                            );
                          }

                          if (libraryState is LibrarySuccessState) {
                            final items =
                                libraryState.libraryResponseEntity.data ?? [];

                            if (items.isEmpty) {
                              return Center(
                                child: Text(
                                  "No recommendations for this mood yet",
                                  style: AppStyles.medium17Gray,
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: const EdgeInsets.only(bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return GestureDetector(
                                  onTap: () {
                                    final moodType = (moodState as MoodSuccessState)
                                        .moodResponseEntity.data?.moodType?.toInt();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LibraryTab(
                                          initialMood: moodType,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16),
                                        child: Image.network(
                                          "$_baseUrl${item.imageUrl}",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.lavenderColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.play_circle_fill,
                                                size: 45,
                                                color: AppColors.lavenderColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.title ?? "No Title",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.bold16Black
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item.type == 0
                                          ? "Music • Podcast"
                                          : "Article • Read",
                                      style: const TextStyle(
                                        color: Color(0xFF8E8E93),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],

                                      ));
                              },
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
