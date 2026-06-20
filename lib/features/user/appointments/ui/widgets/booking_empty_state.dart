import 'package:flutter/material.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/components/custom_button.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../pages/explore_doctors_screen.dart';

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
          const SizedBox(height: 24),
          CustomButton(
            text: "Explore Doctors & Book",
            backgroundColor: AppColors.lavenderColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExploreDoctorsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BookingErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const BookingErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      message: message,
      onRetry: onRetry,
      title: "Connection Problem",
      icon: Icons.wifi_off_rounded,
    );
  }
}
