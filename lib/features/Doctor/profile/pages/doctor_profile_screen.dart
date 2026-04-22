import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../shared/widgets/stats_card.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

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
          style:
              TextStyle(color: AppColors.gray800, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.gray800),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppTheme.spacingMd),

            // Profile Header
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/images/doctor_avatar.png'), // Placeholder
              backgroundColor: AppColors.gray200,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            const Text(
              'Dr. Wafaa Sakr',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.gray800,
              ),
            ),
            const Text(
              'Psychiatrist',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.gray500,
              ),
            ),

            const SizedBox(height: AppTheme.spacingLg),

            // Stats Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
              child: Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      label: 'Rating',
                      value: '4.9',
                      icon: Icons.star,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: StatsCard(
                      label: 'Sessions',
                      value: '128',
                      icon: Icons.chat_bubble,
                      color: AppColors.purpleSoft,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: StatsCard(
                      label: 'Patients',
                      value: '45',
                      icon: Icons.people,
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
                  _buildInfoRow('Specialty', 'Psychiatry'),
                  const Divider(),
                  _buildInfoRow('Experience', '15 Years'),
                  const Divider(),
                  _buildInfoRow('License No.', 'PSY-12345'),
                ],
              ),
            ),

            // Schedule Settings / Availability
            _buildSectionHeader(context, 'Schedule & Availability'),
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
                    leading: const Icon(Icons.calendar_month,
                        color: AppColors.purpleSoft),
                    title: const Text('Availability'),
                    subtitle: const Text('Mon - Fri, 09:00 AM - 05:00 PM'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTheme.spacingLg),

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
                    leading: const Icon(Icons.lock_outline,
                        color: AppColors.gray600),
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.notifications_none,
                        color: AppColors.gray600),
                    title: const Text('Notifications'),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout',
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      // Handle Logout
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.gray800,
          ),
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
          Text(value,
              style: const TextStyle(
                  color: AppColors.gray800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
        ],
      ),
    );
  }
}
