import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cashe/cashe_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../shared/widgets/stats_card.dart';
import '../../ui/manager/doctor_cubit.dart';
import '../../../auth/login/ui/pages/login_screen.dart';

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
          style: TextStyle(color: AppColors.gray800, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state.isLoading && state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.profile == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.gray400),
                  const SizedBox(height: AppTheme.spacingMd),
                  Text(
                    state.error!.errors ?? 'Failed to load profile',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.gray600),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  ElevatedButton(
                    onPressed: () => context.read<DoctorCubit>().getDoctorProfile(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Extract profile — works for both Loaded and Updated states
          final profile = state.profile;

          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppTheme.spacingMd),

                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.purpleBg,
                  backgroundImage: profile.profilePicture != null &&
                          profile.profilePicture!.isNotEmpty
                      ? NetworkImage(profile.profilePicture!)
                      : null,
                  child: profile.profilePicture == null ||
                          profile.profilePicture!.isEmpty
                      ? Text(
                          profile.fullName.isNotEmpty
                              ? profile.fullName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.purpleSoft),
                        )
                      : null,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
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
                _buildSectionHeader(context, 'Professional Info'),
                Container(
                  margin: const EdgeInsets.all(AppTheme.spacingMd),
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
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
                      _buildInfoRow('Specialty',
                          profile.specialization ?? 'Not set'),
                      const Divider(),
                      _buildInfoRow('Email', profile.email ?? 'Not set'),
                      if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                        const Divider(),
                        _buildInfoRow('Bio', profile.bio!),
                      ],
                    ],
                  ),
                ),

                // Settings & Logout
                _buildSectionHeader(context, 'Settings'),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
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
                        leading: const Icon(Icons.logout, color: Colors.red),
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gray800),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: AppColors.gray500, fontSize: 16)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  color: AppColors.gray800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
