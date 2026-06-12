import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import '../../../../core/components/app_card.dart';
import '../manager/mood_cubit.dart';
import '../widgets/buildLibrary_item.dart';
import '../widgets/mood_item.dart';

class HomeTab extends StatefulWidget {

   const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  MoodCubit moodCubit = getIt<MoodCubit>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<MoodCubit, MoodState>(
      listener: (context, state) {
        if (state is MoodErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failures.errors)),
          );
        }
        if (state is MoodSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Mood updated successfully!")),
          );
        }
      },
      builder: (context, state) {
        // بنستخدم الحالة عشان نعرف لو فيه مود مختار حالياً
        int? selectedMood;
        if (state is MoodSuccessState) {
          selectedMood = state.moodResponseEntity.moodType;
        }

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            toolbarHeight: 85,
            backgroundColor: AppColors.grayShad1Color,
            elevation: 0,
            title: Column(
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
                Row(
                  children: [
                    Text("How are you feeling Today, Alex?",
                        style: AppStyles.medium17Gray),
                  ],
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is MoodLoadingState)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),

                Text("Choose your mood", style: AppStyles.bold21Black),
                SizedBox(height: height * 0.015),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: height * 0.008),
                  child: AppCard(
                    borderRadius: 20,
                    elevation: 3,
                    color: AppColors.grayShad1Color,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          // جوه الـ AppCard في الـ HomeTab
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MoodItem(emoji: "😊", label: "Happy", id: 1),
                              MoodItem(emoji: "😨", label: "Scared", id: 2),
                              MoodItem(emoji: "😕", label: "Sad", id: 3),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MoodItem(emoji: "😐", label: "Neutral", id: 4),
                              MoodItem(emoji: "😡", label: "Angry", id: 5),
                              MoodItem(
                                  emoji: "😯", label: "Surprised", id: 6),
                              MoodItem(
                                  emoji: "🤢", label: "Disgusted", id: 7),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                // عنوان المكتبة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    selectedMood != null
                        ? "Recommended for you"
                        : "Recommended Library",
                    style: AppStyles.bold21Black,
                  ),
                ),

                SizedBox(height: height * 0.02),

                Expanded(
                  child: GridView.builder(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const BuildLibraryItem();
                    },
                  ),
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        );
      },
    );
  }
}
