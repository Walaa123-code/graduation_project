import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/cashe/cashe_helper.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/widgets/stats_card.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import 'package:mindecho/features/Doctor/ui/pages/profile/widgets/doctor_avatar_widget.dart';
import 'package:mindecho/features/Doctor/ui/pages/profile/widgets/profile_error_widget.dart';
import 'package:mindecho/features/Doctor/ui/pages/profile/widgets/profile_info_card.dart';
import 'package:mindecho/features/Doctor/ui/pages/profile/widgets/profile_section_header.dart';
import 'package:mindecho/features/auth/login/ui/pages/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorProfile();
  }

  Future<void> _pickAndCropImage(dynamic profile) async {
    final ImagePicker picker = ImagePicker();
    // Capture context before any await so it is not used across an async gap.
    final buildContext = context;
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Picture',
            toolbarColor: AppColors.purpleSoft,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Profile Picture',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
          WebUiSettings(
            // ignore: use_build_context_synchronously
            context: buildContext,
          ),
        ],
      );

      if (croppedFile != null && mounted) {
        context.read<DoctorCubit>().updateDoctorProfile(
              fullName: profile.fullName,
              email: profile.email ?? '',
              specialization: profile.specialization ?? '',
              bio: profile.bio ?? '',
              profilePicturePath: croppedFile.path,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gray800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
              color: AppColors.gray800, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state.isLoading && state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.profile == null) {
            return ProfileErrorWidget(
              message: state.error!.errors ?? 'Failed to load profile',
              onRetry: () => context.read<DoctorCubit>().getDoctorProfile(),
            );
          }

          final profile = state.profile;

          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppTheme.spacingMd),

                // Avatar
                DoctorAvatarWidget(
                  profilePicture: profile.profilePicture,
                  fullName: profile.fullName,
                  onTap: () => _pickAndCropImage(profile),
                ),

                const SizedBox(height: AppTheme.spacingMd),

                Text(
                  'Dr. ${profile.fullName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                  ),
                ),
                Text(
                  profile.specialization ?? 'No specialization',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.gray500,
                  ),
                ),

                const SizedBox(height: AppTheme.spacingLg),

                // Stats
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          label: 'Age',
                          value: '${profile.age}',
                          icon: Icons.cake_outlined,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMd),
                      Expanded(
                        child: StatsCard(
                          label: 'Gender',
                          value: profile.gender == 0 ? 'Male' : 'Female',
                          icon: Icons.person,
                          color: AppColors.purpleSoft,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMd),
                      const Expanded(
                        child: StatsCard(
                          label: 'Email',
                          value: '✓',
                          icon: Icons.email_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppTheme.spacingLg),

                // Professional Info
                const ProfileSectionHeader(title: 'Professional Info'),
                ProfileInfoCard(
                  specialty: profile.specialization ?? 'Not set',
                  email: profile.email ?? 'Not set',
                  bio: profile.bio,
                ),

                // Settings & Logout
                const ProfileSectionHeader(title: 'Settings'),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.logout, color: Colors.red),
                        title: const Text('Logout',
                            style: TextStyle(color: Colors.red)),
                        onTap: () async {
                          await CasheHelper.deleteToken();
                          if (context.mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                              (_) => false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXl),
              ],
            ),
          );
        },
      ),
    );
  }
}
