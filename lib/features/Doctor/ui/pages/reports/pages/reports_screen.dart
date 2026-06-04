import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/report_item.dart';
import '../widgets/weekly_summary_card.dart';
import '../widgets/report_card.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  static const List<ReportItem> _reports = [
    ReportItem(
      title: 'Patient Progress Report',
      date: 'Feb 20, 2026',
      status: 'Completed',
      statusColor: Color(0xFF48BB78),
    ),
    ReportItem(
      title: 'Session Activity Summary',
      date: 'Feb 18, 2026',
      status: 'Completed',
      statusColor: Color(0xFF48BB78),
    ),
    ReportItem(
      title: 'Monthly Revenue Analysis',
      date: 'Feb 15, 2026',
      status: 'Pending',
      statusColor: Color(0xFFFFB84D),
    ),
    ReportItem(
      title: 'Treatment Outcome Report',
      date: 'Feb 10, 2026',
      status: 'Completed',
      statusColor: Color(0xFF48BB78),
    ),
    ReportItem(
      title: 'New Patient Intake Form',
      date: 'Feb 8, 2026',
      status: 'In Review',
      statusColor: Color(0xFF9B7EBD),
    ),
    ReportItem(
      title: 'Appointment Cancellations',
      date: 'Feb 5, 2026',
      status: 'Completed',
      statusColor: Color(0xFF48BB78),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          const WeeklySummaryCard(
            totalPatients: 45,
            completedAppointments: 31,
            revenue: 4820,
          ),
          const SizedBox(height: AppTheme.spacingLg),

          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Reports',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray800,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXs),

          // Report list
          ..._reports.map((report) => ReportCard(report: report)),

          const SizedBox(height: AppTheme.spacingLg),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        'Reports',
        style: TextStyle(
          color: AppColors.gray800,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.file_download_outlined,
              color: AppColors.gray600),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, color: AppColors.gray600),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.gray100),
      ),
    );
  }
}
