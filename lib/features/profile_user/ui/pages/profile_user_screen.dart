import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../di/di.dart';
import '../manager/profile_cubit.dart';
import '../widgets/help&support_screen.dart';
import '../widgets/notifications_screen.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_screen.dart';
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
                          context.read<ProfileCubit>().getProfile(),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: Text("Try Again", style: AppStyles.bold20Whit),
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
