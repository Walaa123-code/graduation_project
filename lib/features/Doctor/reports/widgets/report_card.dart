import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/report_item.dart';

class ReportCard extends StatelessWidget {
  final ReportItem report;

  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // Report icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.purpleBg,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppColors.purpleSoft,
              size: 22,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          // Title & date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  report.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacingXs),
          // Status badge + view button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildStatusBadge(),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: const [
                    Text(
                      'View',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.purpleSoft,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 10, color: AppColors.purpleSoft),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: report.statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Text(
        report.status,
        style: TextStyle(
          color: report.statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
