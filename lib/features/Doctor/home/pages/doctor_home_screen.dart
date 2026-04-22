import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../shared/models/doctor_action_item.dart';
import '../../shared/widgets/action_grid.dart';
import '../../shared/widgets/doctor_header_widget.dart';

import '../../shared/widgets/stats_card.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Actions
    final List<DoctorActionItem> actions = [
      DoctorActionItem(
        title: 'Appointments',
        subtitle: '2 Pending',
        icon: Icons.calendar_month,
        color: AppColors.purpleSoft,
        onTap: () {
          Navigator.pushNamed(context, '/doctor/appointments');
        },
      ),
      DoctorActionItem(
        title: 'Patients',
        subtitle: '3 New',
        icon: Icons.people_alt,
        color: AppColors.primary,
        onTap: () {
          Navigator.pushNamed(context, '/doctor/patients');
        },
      ),
      DoctorActionItem(
        title: 'Messages',
        subtitle: '5 Unread',
        icon: Icons.chat_bubble_outline,
        color: Colors.orange,
        onTap: () {
          Navigator.pushNamed(context, '/doctor/messages');
        },
      ),
      DoctorActionItem(
        title: 'Reports',
        subtitle: 'Weekly Summary',
        icon: Icons.analytics_outlined,
        color: Colors.blue,
        onTap: () {
          Navigator.pushNamed(context, '/doctor/reports');
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            DoctorHeaderWidget(
              doctorName: 'Dr. Wafaa Sakr',
              greeting: 'Good Morning,',
              imageUrl: 'assets/images/doctor_avatar.png', // Placeholder
              onNotificationTap: () {},
              onProfileTap: () {
                // Navigate to Profile
                // Navigator.pushNamed(context, '/doctor-profile');
              },
            ),

            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          label: 'Sessions',
                          value: '12',
                          icon: Icons.video_call,
                          color: AppColors.purpleSoft,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMd),
                      Expanded(
                        child: StatsCard(
                          label: 'Patients',
                          value: '45',
                          icon: Icons.person_outline,
                          color: AppColors.primary,
                        ),
                      ),
                      // Add a third card if needed to match 3-card design
                      const SizedBox(width: AppTheme.spacingMd),
                      Expanded(
                        child: StatsCard(
                          label: 'Rating',
                          value: '4.9',
                          icon: Icons.star_outline,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  // Schedule Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Schedule (0)', // Dynamic count
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingSm),

                  // Empty State or List
                  // For now, let's show one dummy card or empty state text
                  // "No appointments today" if empty
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppTheme.spacingXl),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      border: Border.all(color: AppColors.gray200),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 48, color: AppColors.gray300),
                        const SizedBox(height: AppTheme.spacingMd),
                        Text(
                          'No appointments today',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  // Quick Actions
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  ActionGrid(actions: actions),

                  const SizedBox(height: AppTheme.spacingLg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
