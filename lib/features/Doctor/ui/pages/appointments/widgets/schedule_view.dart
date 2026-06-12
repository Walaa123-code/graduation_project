import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final DateTime _today = DateTime.now();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _today;
    
    // Read the doctor ID from DoctorCubit
    final doctorId = context.read<DoctorCubit>().state.profile?.id ?? '';
    context.read<ScheduleCubit>().getSchedules(doctorId: doctorId);
  }

  List<DateTime> get _weekDays {
    final monday = _today.subtract(Duration(days: _today.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  static const List<String> _dayLabels = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  String _monthLabel(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Maps weekday (Mon=1..Sun=7) to API dayOfWeek (Sun=0,Mon=1..Sat=6)
  int _selectedDayOfWeek() => _selectedDate.weekday % 7;

  /// Returns schedules for the selected day of week
  List<ScheduleEntity> _schedulesForDay(
      List<ScheduleEntity> all, int dayOfWeek) {
    return all.where((s) => s.dayOfWeek == dayOfWeek && s.isActive).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        final List<ScheduleEntity> schedules = state is ScheduleListLoadedState
            ? (state as ScheduleListLoadedState).schedules
            : const <ScheduleEntity>[];
        final isLoading = state is ScheduleLoadingState;

        final daySchedules =
            _schedulesForDay(schedules, _selectedDayOfWeek());

        return Column(
          children: [
            _WeekDayPicker(
              weekDays: _weekDays,
              dayLabels: _dayLabels,
              selectedDate: _selectedDate,
              today: _today,
              isSameDay: _isSameDay,
              onDaySelected: (d) => setState(() => _selectedDate = d),
            ),
            _DateHeader(
              label: _monthLabel(_selectedDate),
              appointmentCount: daySchedules.length,
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : daySchedules.isEmpty
                      ? const _EmptyDayState()
                      : ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          itemCount: daySchedules.length,
                          itemBuilder: (context, index) {
                            return _ScheduleSlotRow(
                              schedule: daySchedules[index],
                            );
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
}

// ── Week Day Picker ───────────────────────────────────────────────────────────

class _WeekDayPicker extends StatelessWidget {
  final List<DateTime> weekDays;
  final List<String> dayLabels;
  final DateTime selectedDate;
  final DateTime today;
  final bool Function(DateTime, DateTime) isSameDay;
  final ValueChanged<DateTime> onDaySelected;

  const _WeekDayPicker({
    required this.weekDays,
    required this.dayLabels,
    required this.selectedDate,
    required this.today,
    required this.isSameDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
      child: Row(
        children: List.generate(weekDays.length, (i) {
          final day = weekDays[i];
          final isSelected = isSameDay(day, selectedDate);
          final isToday = isSameDay(day, today);

          return Expanded(
            child: GestureDetector(
              onTap: () => onDaySelected(day),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dayLabels[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? AppColors.primary : AppColors.gray400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFF9B7EBD), Color(0xFF5B6EE8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isSelected ? null : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? AppColors.white
                              : isToday
                                  ? AppColors.primary
                                  : AppColors.gray700,
                        ),
                      ),
                    ),
                  ),
                  if (isToday && !isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Date Header ───────────────────────────────────────────────────────────────

class _DateHeader extends StatelessWidget {
  final String label;
  final int appointmentCount;

  const _DateHeader({required this.label, required this.appointmentCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.purpleBg,
              borderRadius:
                  BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Text(
              '$appointmentCount slot${appointmentCount == 1 ? '' : 's'}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.purpleSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty Day State ───────────────────────────────────────────────────────────

class _EmptyDayState extends StatelessWidget {
  const _EmptyDayState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: AppColors.gray300),
          SizedBox(height: AppTheme.spacingMd),
          Text(
            'No active slots on this day',
            style: TextStyle(color: AppColors.gray500, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// ── Real Schedule Slot Row ─────────────────────────────────────────────────────

class _ScheduleSlotRow extends StatelessWidget {
  final ScheduleEntity schedule;

  const _ScheduleSlotRow({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEEE6FF), Color(0xFFE0E8FF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppColors.purpleLight, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.purpleSoft,
                borderRadius:
                    BorderRadius.circular(AppTheme.radiusFull),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.access_time_rounded,
                size: 18, color: AppColors.purpleSoft),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${schedule.startTime} – ${schedule.endTime}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.purpleSoft,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Slot ID #${schedule.id}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: schedule.isActive
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : AppColors.gray200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                schedule.isActive ? 'Active' : 'Off',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: schedule.isActive
                      ? AppColors.primary
                      : AppColors.gray500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
