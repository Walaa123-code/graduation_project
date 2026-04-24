class ScheduleEntity {
  final int id;
  final String doctorId;
  final int dayOfWeek; // 0=Sun … 6=Sat
  final String startTime;
  final String endTime;
  final bool isActive;

  const ScheduleEntity({
    required this.id,
    required this.doctorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isActive,
  });
}
