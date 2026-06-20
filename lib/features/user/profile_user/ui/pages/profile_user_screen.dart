import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import '../manager/profile_cubit.dart';
import '../widgets/help&support/help&support_screen.dart';
import '../widgets/custom/notifications_screen.dart';
import '../widgets/custom/profile_header.dart';
import '../widgets/custom/logout_button.dart';
import '../widgets/custom/profile_item_tile.dart';
import '../widgets/custom/profile_personal_info_card.dart';
import '../widgets/custom/profile_state_row.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9FB),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileErrorState) {
              return AppErrorWidget(
                message: state.failures.errors.toString(),
                onRetry: () => context.read<ProfileCubit>().getProfile(),
                title: "Couldn't load profile",
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
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const ProfileStatsRow(),
                        const SizedBox(height: 20),

                        ProfilePersonalInfoCard(
                          age: response?.age,
                          gender: response?.gender,
                          id: response?.id,
                        ),
                        const SizedBox(height: 20),

                        ProfileItemTile(
                          icon: Icons.notifications_outlined,
                          title: "Notifications",
                          titleStyle: AppStyles.medium16Black,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                            );
                          },
                        ),
                        ProfileItemTile(
                          icon: Icons.settings_outlined,
                          title: "Help & Support",
                          titleStyle: AppStyles.medium16Black,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
                            );
                          },
                        ),

                        const SizedBox(height: 40),
                        const LogoutButton(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}