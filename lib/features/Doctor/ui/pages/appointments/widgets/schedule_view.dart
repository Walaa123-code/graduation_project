import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';

import '../../../../../../core/theme/app_colors.dart';

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
    return all.where((s) => s.dayOfWeek == dayOfWeek).toList();
  }

  void _showAddScheduleModal(BuildContext context, int preselectedDay) {
    int selectedDay = preselectedDay;
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    // خزنّا الـ Cubit في متغير عشان نقدر نستخدمه جوه الـ BottomSheet بأمان
    final scheduleCubit = context.read<ScheduleCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BlocProvider.value(
          value: scheduleCubit,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  top: 24,
                  left: 24,
                  right: 24,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.gray300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Add Working Hours',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.gray800),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text('Select Day', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.gray600)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.gray200),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedDay,
                          isExpanded: true,
                          items: List.generate(7, (index) => DropdownMenuItem(
                            value: index,
                            child: Text(days[index]),
                          )),
                          onChanged: (val) {
                            if (val != null) setModalState(() => selectedDay = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Start Time', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.gray600)),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                  if (time != null) setModalState(() => startTime = time);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray50,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: startTime != null ? AppColors.primary : AppColors.gray200),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16, color: startTime != null ? AppColors.primary : AppColors.gray400),
                                      const SizedBox(width: 8),
                                      Text(
                                        startTime?.format(context) ?? 'Tap to set',
                                        style: TextStyle(color: startTime != null ? AppColors.gray800 : AppColors.gray400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('End Time', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.gray600)),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                  if (time != null) setModalState(() => endTime = time);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray50,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: endTime != null ? AppColors.primary : AppColors.gray200),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16, color: endTime != null ? AppColors.primary : AppColors.gray400),
                                      const SizedBox(width: 8),
                                      Text(
                                        endTime?.format(context) ?? 'Tap to set',
                                        style: TextStyle(color: endTime != null ? AppColors.gray800 : AppColors.gray400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (startTime == null || endTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select start and end times')),
                          );
                          return;
                        }
                        final startFormatted = '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00';
                        final endFormatted = '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00';

                        context.read<ScheduleCubit>().addSchedule(
                          dayOfWeek: selectedDay,
                          startTime: startFormatted,
                          endTime: endFormatted,
                        );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Save Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScheduleCubit, ScheduleState>(
          listener: (context, state) {
            if (state is ScheduleAddedState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Schedule added successfully!')),
              );
              final doctorId = context.read<DoctorCubit>().state.profile?.id ?? '';
              context.read<ScheduleCubit>().getSchedules(doctorId: doctorId);
            } else if (state is ScheduleDeletedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🗑️ Schedule deleted!')),
              );
              final doctorId = context.read<DoctorCubit>().state.profile?.id ?? '';
              context.read<ScheduleCubit>().getSchedules(doctorId: doctorId);
            } else if (state is ScheduleErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.errors ?? 'Something went wrong')),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          final List<ScheduleEntity> schedules = state is ScheduleListLoadedState
              ? state.schedules
              : const <ScheduleEntity>[];
          final isLoading = state is ScheduleLoadingState;

          final daySchedules = _schedulesForDay(schedules, _selectedDayOfWeek());

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
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(16, 4, 8, 10),
                child: Row(
                  children: [
                    Text(
                      _monthLabel(_selectedDate),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.gray800),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.purpleBg,
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: Text(
                        '${daySchedules.length} slot${daySchedules.length == 1 ? '' : 's'}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.purpleSoft),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => _showAddScheduleModal(context, _selectedDayOfWeek()),
                      icon: const Icon(Icons.add_circle_outline, size: 18),
                      label: const Text('Add Slot'),
                      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : daySchedules.isEmpty
                    ? _EmptyDayState(onAdd: () => _showAddScheduleModal(context, _selectedDayOfWeek()))
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: daySchedules.length,
                  itemBuilder: (context, index) {
                    return _ScheduleSlotRow(
                      schedule: daySchedules[index],
                      onDelete: () => context.read<ScheduleCubit>().deleteSchedule(id: daySchedules[index].id),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

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

class _EmptyDayState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyDayState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.event_busy, size: 64, color: AppColors.gray300),
          const SizedBox(height: AppTheme.spacingMd),
          const Text(
            'No slots on this day',
            style: TextStyle(color: AppColors.gray500, fontSize: 15),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          OutlinedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add Availability'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleSlotRow extends StatelessWidget {
  final ScheduleEntity schedule;
  final VoidCallback onDelete;

  const _ScheduleSlotRow({required this.schedule, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    // حفظنا الـ Cubit هنا كمان عشان الـ AlertDialog
    final scheduleCubit = context.read<ScheduleCubit>();

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
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.purpleSoft,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.access_time_rounded, size: 18, color: AppColors.purpleSoft),
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: schedule.isActive
                              ? AppColors.primary.withValues(alpha: 0.12)
                              : AppColors.gray200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          schedule.isActive ? '● Active' : '● Off',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: schedule.isActive ? AppColors.primary : AppColors.gray500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.error, size: 22),
              tooltip: 'Delete slot',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: scheduleCubit,
                    child: AlertDialog(
                      title: const Text('Delete Slot'),
                      content: const Text('Are you sure you want to delete this schedule slot?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onDelete();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                          child: const Text('Delete', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}