import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/models/doctor_action_item.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/widgets/action_grid.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/widgets/doctor_header_widget.dart';
import 'package:mindecho/features/Doctor/ui/widgets/shared/widgets/schedule_tile_card.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';
import 'package:mindecho/features/Doctor/ui/pages/home/widgets/empty_schedule.dart';
import 'package:mindecho/features/Doctor/ui/pages/home/widgets/stats_row.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class DoctorHomeScreen extends StatefulWidget {
  final void Function(int index)? onTabChange;
  const DoctorHomeScreen({super.key, this.onTabChange});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorProfile();
  }

  @override
  Widget build(BuildContext context) {
    final List<DoctorActionItem> actions = [
      DoctorActionItem(
        title: 'Appointments',
        subtitle: 'Schedule',
        icon: Icons.calendar_month,
        color: AppColors.purpleSoft,
        onTap: () {
          if (widget.onTabChange != null) {
            widget.onTabChange!(2); // 2 is Appointments/Schedule tab
          } else {
            Navigator.pushNamed(context, '/doctor/appointments');
          }
        },
      ),
      DoctorActionItem(
        title: 'Patients',
        subtitle: 'My Patients',
        icon: Icons.people_alt,
        color: AppColors.primary,
        onTap: () {
          if (widget.onTabChange != null) {
            widget.onTabChange!(1); // 1 is Patients tab
          } else {
            Navigator.pushNamed(context, '/doctor/patients');
          }
        },
      ),
      DoctorActionItem(
        title: 'Messages',
        subtitle: 'Inbox',
        icon: Icons.chat_bubble_outline,
        color: Colors.orange,
        onTap: () => Navigator.pushNamed(context, '/doctor/messages'),
      ),
      DoctorActionItem(
        title: 'Profile',
        subtitle: 'My Profile',
        icon: Icons.person_outline,
        color: Colors.blue,
        onTap: () {
          if (widget.onTabChange != null) {
            widget.onTabChange!(3); // 3 is Profile tab
          } else {
            Navigator.pushNamed(context, '/doctor/profile');
          }
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: BlocListener<DoctorCubit, DoctorState>(
        listenWhen: (previous, current) =>
            previous.profile == null && current.profile != null,
        listener: (context, state) {
          if (state.profile != null) {
            context.read<ScheduleCubit>().getSchedules(doctorId: state.profile!.id);
          }
        },
        child: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, doctorState) {
          final doctorName = doctorState.profile != null
              ? 'Dr. ${doctorState.profile!.fullName}'
              : 'Doctor';
          final specialization = doctorState.profile?.specialization ?? '';
          final profilePic = doctorState.profile?.profilePicture;

          return SingleChildScrollView(
            child: Column(
              children: [
                DoctorHeaderWidget(
                  doctorName: doctorName,
                  greeting: 'Good Morning,',
                  imageUrl: profilePic ?? '',
                  onNotificationTap: () {},
                  onProfileTap: () {},
                ),

                Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Row
                      BlocBuilder<ScheduleCubit, ScheduleState>(
                        builder: (ctx, schedState) {
                          final schedCount = schedState is ScheduleListLoadedState
                              ? schedState.schedules.length
                              : 0;
                          final patientCount = doctorState.patients?.totalCount ?? 0;
                          return StatsRow(
                            specialization: specialization,
                            scheduleCount: schedCount,
                            patientCount: patientCount,
                          );
                        },
                      ),

                      const SizedBox(height: AppTheme.spacingLg),

                      // Today's Schedule from API
                      BlocBuilder<ScheduleCubit, ScheduleState>(
                        builder: (ctx, schedState) {
                          final schedules = schedState is ScheduleListLoadedState
                              ? schedState.schedules
                              : <dynamic>[];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'My Schedules (${schedules.length})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (widget.onTabChange != null) {
                                        widget.onTabChange!(2);
                                      } else {
                                        Navigator.pushNamed(context, '/doctor/appointments');
                                      }
                                    },
                                    child: const Text('View All'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppTheme.spacingSm),

                              if (schedState is ScheduleLoadingState)
                                const Center(child: CircularProgressIndicator())
                              else if (schedules.isEmpty)
                                const EmptySchedule()
                              else
                                ...schedules.take(3).map((s) {
                                  const days = [
                                    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
                                  ];
                                  // ignore: avoid_dynamic_calls
                                  final dayLabel = days[(s as dynamic).dayOfWeek % 7];
                                  return ScheduleTileCard(
                                    startTime: s.startTime as String,
                                    endTime: s.endTime as String,
                                    dayLabel: dayLabel,
                                    slotId: s.id,
                                    isActive: s.isActive as bool,
                                  );
                                }),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: AppTheme.spacingLg),

                      // Quick Actions
                      Text(
                        'Quick Actions',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      ActionGrid(actions: actions),
                      const SizedBox(height: AppTheme.spacingLg),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}

