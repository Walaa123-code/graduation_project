import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import '../../../../../core/api/api_constants.dart';
import '../../../libiraries/ui/manager/library_cubit.dart';
import '../../../libiraries/ui/pages/library_tab.dart';
import '../manager/mood_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/library_empty_hint.dart';
import '../widgets/library_recommendation_card.dart';
import '../widgets/mood_selector_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final MoodCubit _moodCubit = getIt<MoodCubit>();
  final LibraryCubit _libraryCubit = getIt<LibraryCubit>();

  int? _currentMoodType;

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
              content: Text(
                friendlyErrorMessage(state.failures.errors.toString()),
                style: AppStyles.medium16White,
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ));
          }
          if (state is MoodSuccessState) {
            _currentMoodType = state.moodResponseEntity.data?.moodType?.toInt() ?? 1;
            _libraryCubit.getLibrary(_currentMoodType!);
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
              appBar: const HomeAppBar(),
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
                      padding: EdgeInsets.symmetric(horizontal: height * 0.008),
                      child: const MoodSelectorCard(),
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
                          if (!moodSelected && libraryState is LibraryInitialState) {
                            return const LibraryEmptyHint();
                          }

                          if (libraryState is LibraryLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.lavenderColor),
                            );
                          }

                          if (libraryState is LibraryErrorState) {
                            return AppErrorWidget(
                              message: libraryState.failures.errors.toString(),
                              onRetry: () => _libraryCubit.getLibrary(_currentMoodType ?? 1),
                              title: "Couldn't load recommendations",
                              icon: Icons.menu_book_outlined,
                            );
                          }

                          if (libraryState is LibrarySuccessState) {
                            final items = libraryState.libraryResponseEntity.data ?? [];

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
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return LibraryRecommendationCard(
                                  imageUrl: "${ApiConstants.baseUrl}${item.imageUrl}",
                                  title: item.title ?? "No Title",
                                  type: item.type?.toInt() ?? 1,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LibraryTab(
                                          initialMood: _currentMoodType,
                                        ),
                                      ),
                                    );
                                  },
                                );
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