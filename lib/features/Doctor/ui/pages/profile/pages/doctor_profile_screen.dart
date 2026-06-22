import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/cashe/cashe_helper.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/widgets/stats_card.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';
import 'package:mindecho/features/auth/login/ui/pages/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

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
            context: context,
            presentStyle: WebPresentStyle.dialog,
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

  void _showAddScheduleModal(BuildContext context) {
    int selectedDay = 0; // 0 = Sunday
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                top: 24,
                left: 24,
                right: 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.gray300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Add Working Hours',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Text('Select Day', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.gray600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.gray50,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.gray200),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedDay,
                        isExpanded: true,
                        items: List.generate(7, (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Text(days[index]),
                          );
                        }),
                        onChanged: (val) {
                          if (val != null) setModalState(() => selectedDay = val);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Start Time', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.gray600)),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                if (time != null) setModalState(() => startTime = time);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.gray50,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: AppColors.gray200),
                                ),
                                child: Text(
                                  startTime?.format(context) ?? 'Select Time',
                                  style: TextStyle(color: startTime != null ? AppColors.gray800 : AppColors.gray400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('End Time', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.gray600)),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                if (time != null) setModalState(() => endTime = time);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.gray50,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: AppColors.gray200),
                                ),
                                child: Text(
                                  endTime?.format(context) ?? 'Select Time',
                                  style: TextStyle(color: endTime != null ? AppColors.gray800 : AppColors.gray400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (startTime == null || endTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select start and end times')));
                        return;
                      }
                      
                      // Format times to HH:mm:ss for backend
                      final startFormatted = '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00';
                      final endFormatted = '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00';
                      
                      this.context.read<ScheduleCubit>().addSchedule(
                        dayOfWeek: selectedDay,
                        startTime: startFormatted,
                        endTime: endFormatted,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('Add Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScheduleCubit, ScheduleState>(
          listener: (context, state) {
            if (state is ScheduleAddedState) {
              Navigator.of(context).pop(); // Close modal
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Schedule added successfully!')),
              );
              final profile = context.read<DoctorCubit>().state.profile;
              if (profile != null) {
                context.read<ScheduleCubit>().getSchedules(doctorId: profile.id);
              }
            } else if (state is ScheduleErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.errors ?? 'Failed to add schedule')),
              );
            }
          },
        ),
      ],
      child: Scaffold(
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

            final profile = state.profile;
            if (profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppTheme.spacingMd),
                  // Avatar
                  GestureDetector(
                    onTap: () => _pickAndCropImage(profile),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 55,
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
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.purpleSoft),
                                  )
                                : null,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  Text(
                    'Dr. ${profile.fullName}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gray800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.purpleBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      profile.specialization ?? 'Specialization not set',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purpleSoft,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingXl),

                  // Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
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
                      ],
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingXl),

                  // Working Hours Section
                  _buildSectionHeader(context, 'Working Hours', action: IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primary),
                    onPressed: () => _showAddScheduleModal(context),
                  )),
                  BlocBuilder<ScheduleCubit, ScheduleState>(
                    builder: (context, schedState) {
                      final schedules = schedState is ScheduleListLoadedState ? schedState.schedules : <dynamic>[];
                      
                      if (schedState is ScheduleLoadingState) {
                        return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
                      }

                      if (schedules.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                          padding: const EdgeInsets.all(AppTheme.spacingXl),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                            border: Border.all(color: AppColors.gray200, width: 1),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.event_busy, size: 48, color: AppColors.gray300),
                              const SizedBox(height: AppTheme.spacingMd),
                              const Text('No working hours set', style: TextStyle(color: AppColors.gray600, fontSize: 16)),
                              const SizedBox(height: AppTheme.spacingMd),
                              OutlinedButton.icon(
                                onPressed: () => _showAddScheduleModal(context),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Availability'),
                              )
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: schedules.length,
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                        itemBuilder: (context, index) {
                          final s = schedules[index];
                          const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                          final dayLabel = days[(s as dynamic).dayOfWeek % 7];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.purpleBg,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.access_time_filled, color: AppColors.purpleSoft),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(dayLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.gray800)),
                                      const SizedBox(height: 4),
                                      Text('${s.startTime} - ${s.endTime}', style: const TextStyle(color: AppColors.gray500, fontSize: 14)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                  onPressed: () {
                                    context.read<ScheduleCubit>().deleteSchedule(id: s.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  // Professional Info
                  _buildSectionHeader(context, 'Professional Info'),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                    padding: const EdgeInsets.all(AppTheme.spacingLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Email', profile.email ?? 'Not set', Icons.email_outlined),
                        if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(height: 1),
                          ),
                          _buildInfoRow('Bio', profile.bio!, Icons.info_outline),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  // Settings & Logout
                  _buildSectionHeader(context, 'Settings'),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.logout, color: Colors.red),
                      ),
                      title: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16)),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.gray400),
                      onTap: () async {
                        await CasheHelper.deleteToken();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (_) => false,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXl * 2),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {Widget? action}) {
    return Padding(
      padding: const EdgeInsets.only(left: AppTheme.spacingLg, right: AppTheme.spacingMd, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800),
          ),
          if (action != null) action,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.gray400),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppColors.gray500, fontSize: 13, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: AppColors.gray800, fontWeight: FontWeight.w600, fontSize: 15)),
            ],
          ),
        ),
      ],
    );
  }
}
