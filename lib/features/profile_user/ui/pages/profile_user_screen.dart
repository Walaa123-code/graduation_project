import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/features/profile_user/ui/manager/profile_cubit.dart';
import 'package:graduation_project/features/profile_user/ui/widgets/help&support_screen.dart';
import 'package:graduation_project/features/profile_user/ui/widgets/notifications_screen.dart';
import 'package:graduation_project/features/profile_user/ui/widgets/profile_header.dart';
import 'package:graduation_project/features/profile_user/ui/widgets/settings_screen.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../di/di.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_item_tile.dart';
import '../widgets/state_card.dart';

class ProfileUserScreen extends StatelessWidget {
  // ProfileCubit profileCubit = getIt<ProfileCubit>();
  const ProfileUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileErrorState) {
            return Center(child: Text(state.failures.errors.toString()));
          } else if (state is ProfileSuccessState) {
            var response = state.profileResponseEntity.data;

            return Column(
              children: [
                ProfileHeader(
                  userName: response?.fullName ?? "",
                  userEmail: response?.email ?? "",
                  imageUrl: response?.profilePicture ?? '',
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          "7",
                          "Session",
                          labelStyle: AppStyles.medium14DarkGray,
                          valueStyle: AppStyles.bold17Lavender,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: StatCard(
                        "28",
                        "Exercises",
                        labelStyle: AppStyles.medium14DarkGray,
                        valueStyle: AppStyles.bold17Lavender,
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: StatCard(
                        "14",
                        "Days",
                        labelStyle: AppStyles.medium14DarkGray,
                        valueStyle: AppStyles.bold17Lavender,
                      )),
                    ],
                  ),
                ),

                /// settings list
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ProfileItemTile(
                        icon: Icons.notifications_outlined,
                        title: "Notifications",
                        titleStyle: AppStyles.medium16Black,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationsScreen()));
                        },
                      ),
                      ProfileItemTile(
                        icon: Icons.settings_outlined,
                        title: "Settings",
                        titleStyle: AppStyles.medium16Black,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SettingsScreen()));
                        },
                      ),
                      ProfileItemTile(
                        icon: Icons.dark_mode_outlined,
                        title: "Dark Mode",
                        titleStyle: AppStyles.medium16Black,
                      ),
                      ProfileItemTile(
                        icon: Icons.help_outline,
                        title: "Help & Support",
                        titleStyle: AppStyles.medium16Black,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HelpSupportScreen()));
                        },
                      ),
                      const SizedBox(height: 20),
                      const LogoutButton(),
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
