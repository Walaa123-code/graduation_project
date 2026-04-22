import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/appointment_item.dart';
import '../widgets/appointments_header.dart';
import '../widgets/appointments_tab_bar.dart';
import '../widgets/appointments_search_bar.dart';
import '../widgets/appointment_card.dart';
import '../widgets/schedule_view.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedTab = 0;

  static const List<AppointmentItem> _upcoming = [
    AppointmentItem(
      patientName: 'Ahmed Mohamed',
      patientInitials: 'AM',
      avatarColor: Color(0xFF9B7EBD),
      status: AppointmentStatus.confirmed,
      durationMinutes: 60,
      date: 'Feb 26, 2026',
      time: '10:00 AM',
      sessionType: SessionType.online,
      notes: 'Follow-up on anxiety treatment plan.',
    ),
    AppointmentItem(
      patientName: 'Fatima Ali',
      patientInitials: 'FA',
      avatarColor: Color(0xFF4ECDC4),
      status: AppointmentStatus.pending,
      durationMinutes: 45,
      date: 'Feb 27, 2026',
      time: '2:30 PM',
      sessionType: SessionType.inPerson,
      notes: 'Initial consultation – depression screening.',
    ),
    AppointmentItem(
      patientName: 'Omar Hassan',
      patientInitials: 'OH',
      avatarColor: Color(0xFFFF6B6B),
      status: AppointmentStatus.confirmed,
      durationMinutes: 30,
      date: 'Feb 28, 2026',
      time: '11:15 AM',
      sessionType: SessionType.online,
    ),
  ];

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
                ? _UpcomingList(appointments: _upcoming)
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All Upcoming Appointments',
              style: const TextStyle(
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_outlined,
              size: 56, color: AppColors.gray300),
          const SizedBox(height: 12),
          const Text(
            'No appointments here',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.gray500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'This list is currently empty.',
            style: TextStyle(fontSize: 13, color: AppColors.gray400),
          ),
        ],
      ),
    );
  }
}
