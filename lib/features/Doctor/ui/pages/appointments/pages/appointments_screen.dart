import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/features/user/appointments/ui/manager/booking_cubit.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import '../models/appointment_item.dart';
import '../widgets/appointments_header.dart';
import '../widgets/appointments_tab_bar.dart';
import '../widgets/appointments_search_bar.dart';
import '../widgets/appointment_card.dart';
import '../widgets/schedule_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().getAllBookings(isDoctor: true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          // Gradient header (includes SafeArea top)
          const AppointmentsHeader(),

          // Tab bar
          AppointmentsTabBar(
            selectedIndex: _selectedTab,
            onTabChanged: (i) => setState(() => _selectedTab = i),
          ),

          // Body switches between Upcoming list and Schedule calendar view
          Expanded(
            child: _selectedTab == 0
                ? BlocBuilder<BookingCubit, BookingState>(
                    builder: (context, state) {
                      if (state is BookingLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is BookingErrorState) {
                        return Center(child: Text(state.failure.errors ?? 'Failed to load bookings'));
                      }
                      if (state is BookingsLoadedState) {
                        final items = state.bookings.map((b) {
                          return AppointmentItem(
                            patientName: 'Patient ${b.userId.length > 4 ? b.userId.substring(0,4) : b.userId}',
                            patientInitials: 'PT',
                            avatarColor: const Color(0xFF9B7EBD),
                            status: b.bookingStatus == 0 ? AppointmentStatus.pending : b.bookingStatus == 2 ? AppointmentStatus.cancelled : AppointmentStatus.confirmed,
                            durationMinutes: 60,
                            date: b.requestedAt.contains('T') ? b.requestedAt.split('T')[0] : b.requestedAt,
                            time: b.requestedAt.contains('T') ? b.requestedAt.split('T')[1].substring(0, 5) : '',
                            sessionType: SessionType.online,
                          );
                        }).toList();
                        return _UpcomingList(appointments: items);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                : const ScheduleView(),
          ),
        ],
      ),
    );
  }
}

// ── Upcoming appointments list ─────────────────────────────────────────────

class _UpcomingList extends StatelessWidget {
  final List<AppointmentItem> appointments;

  const _UpcomingList({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppointmentsSearchBar(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All Upcoming Appointments',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.gray800,
              ),
            ),
          ),
        ),
        Expanded(
          child: appointments.isEmpty
              ? const _EmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) =>
                      AppointmentCard(appointment: appointments[index]),
                ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_outlined,
              size: 56, color: AppColors.gray300),
          SizedBox(height: 12),
          Text(
            'No appointments here',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.gray500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'This list is currently empty.',
            style: TextStyle(fontSize: 13, color: AppColors.gray400),
          ),
        ],
      ),
    );
  }
}
