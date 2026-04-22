import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  // Base date: today (Feb 24 2026 based on current time)
  final DateTime _today = DateTime(2026, 2, 24);
  late DateTime _selectedDate;

  // Dummy booked slots for demo  – key = "yyyy-MM-dd HH"
  static const Set<String> _bookedSlots = {
    '2026-02-24 10',
    '2026-02-26 09',
    '2026-02-27 14',
  };

  @override
  void initState() {
    super.initState();
    _selectedDate = _today;
  }

  /// Returns the list of 7 days starting from Monday of the current week.
  List<DateTime> get _weekDays {
    final monday = _today.subtract(Duration(days: _today.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  static const List<String> _dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  String _monthLabel(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  String _slotKey(DateTime date, int hour) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')} '
      '${hour.toString().padLeft(2, '0')}';

  bool _isBooked(int hour) =>
      _bookedSlots.contains(_slotKey(_selectedDate, hour));

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int get _appointmentsOnDay =>
      List.generate(24, (h) => h).where((h) => _isBooked(h)).length;

  @override
  Widget build(BuildContext context) {
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
          appointmentCount: _appointmentsOnDay,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            // Show hours 08:00 – 20:00
            itemCount: 13,
            itemBuilder: (context, index) {
              final hour = 8 + index;
              return _TimeSlotRow(
                hour: hour,
                isBooked: _isBooked(hour),
              );
            },
          ),
        ),
      ],
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
                      color: isSelected ? AppColors.primary : AppColors.gray400,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.purpleBg,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Text(
              '$appointmentCount appointment${appointmentCount == 1 ? '' : 's'}',
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

// ── Time Slot Row ─────────────────────────────────────────────────────────────

class _TimeSlotRow extends StatelessWidget {
  final int hour;
  final bool isBooked;

  const _TimeSlotRow({required this.hour, required this.isBooked});

  String get _timeLabel {
    final h = hour.toString().padLeft(2, '0');
    return '$h:00';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time label
          SizedBox(
            width: 48,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _timeLabel,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.gray400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Slot card
          Expanded(
            child: isBooked ? _BookedSlot() : _AvailableSlot(),
          ),
        ],
      ),
    );
  }
}

class _AvailableSlot extends StatelessWidget {
  const _AvailableSlot();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Icons.access_time_rounded, size: 15, color: AppColors.gray300),
          const SizedBox(width: 8),
          const Text(
            'Available for booking',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookedSlot extends StatelessWidget {
  const _BookedSlot();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
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
          const SizedBox(width: 12),
          Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.purpleSoft,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.person_outline_rounded,
              size: 16, color: AppColors.purpleSoft),
          const SizedBox(width: 6),
          const Text(
            'Appointment booked',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.purpleSoft,
            ),
          ),
        ],
      ),
    );
  }
}
