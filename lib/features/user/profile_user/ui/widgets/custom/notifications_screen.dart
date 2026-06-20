import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../../manager/notification_cubit.dart';
import 'notifications_cards.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text("Notifications", style: AppStyles.bold24Black),
        actions: [
          TextButton(
            onPressed: () => context.read<NotificationCubit>().clearNotifications(),
            child: const Text(
              "Clear all",
              style: TextStyle(
                color: AppColors.lavenderColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {

          if (state is NotificationInitialState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.lavenderColor,
              ),
            );
          }

          if (state is NotificationUpdatedState) {
            final notifications = state.notifications;

            if (notifications.isEmpty) {
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
                        Icons.notifications_off_outlined,
                        size: 48,
                        color: AppColors.lavenderColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("No notifications yet", style: AppStyles.bold20Black),
                    const SizedBox(height: 8),
                    Text(
                      "You'll be notified about your bookings here",
                      style: AppStyles.medium16Gray,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return NotificationCard(
                  title: 'Booking ${notif.status ?? "Updated"}',
                  subtitle: notif.message ?? 'Your booking status has changed',
                  doctorName: notif.doctorName,
                  isNew: index == 0,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

