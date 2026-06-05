import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class BookingEmptyState extends StatelessWidget {
  const BookingEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.purpleBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: 50,
              color: AppColors.lavenderColor,
            ),
          ),
          const SizedBox(height: 20),
          Text("No appointments found", style: AppStyles.bold20Black),
          const SizedBox(height: 8),
          Text("Your bookings will appear here", style: AppStyles.medium16Gray),
        ],
      ),
    );
  }
}

class BookingErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const BookingErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.cloud_off_rounded,
                size: 75, color: AppColors.gray300),
            const SizedBox(height: 20),
            Text("Connection Problem", style: AppStyles.bold20Black),
            const SizedBox(height: 10),
            Text(message,
                textAlign: TextAlign.center,
                style: AppStyles.medium16DarkGray),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: Text("Try Again", style: AppStyles.bold20Whit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lavenderColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
