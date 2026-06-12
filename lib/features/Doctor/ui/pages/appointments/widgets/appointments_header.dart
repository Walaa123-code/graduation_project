import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/features/appointments/ui/manager/booking_cubit.dart';

/// Gradient header card for the Appointments screen.
/// Shows title, subtitle, and three quick-stat counters.
class AppointmentsHeader extends StatelessWidget {
  const AppointmentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9B7EBD), Color(0xFF5B6EE8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row
              const Text(
                'Appointments Management',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Track appointments and requests',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              // Stat cards row
              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  int completedCount = 0;
                  int upcomingCount = 0;
                  int todayCount = 0;
                  
                  if (state is BookingsLoadedState) {
                    final now = DateTime.now();
                    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
                    
                    for (var b in state.bookings) {
                      if (b.bookingStatus == 3) completedCount++;
                      if (b.bookingStatus == 1 || b.bookingStatus == 0) upcomingCount++;
                      if (b.requestedAt.startsWith(todayStr)) todayCount++;
                    }
                  }
                  
                  return Row(
                    children: [
                      _StatChip(label: 'Completed', value: completedCount.toString()),
                      const SizedBox(width: 10),
                      _StatChip(label: 'Upcoming', value: upcomingCount.toString()),
                      const SizedBox(width: 10),
                      _StatChip(label: 'Today', value: todayCount.toString()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.80),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
