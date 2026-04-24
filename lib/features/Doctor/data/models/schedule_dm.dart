import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';

class ScheduleDM extends ScheduleEntity {
  ScheduleDM({
    required super.id,
    required super.doctorId,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.isActive,
  });

  factory ScheduleDM.fromJson(Map<String, dynamic> json) {
    return ScheduleDM(
      id: json['id'] as int? ?? 0,
      doctorId: json['doctorId'] as String? ?? '',
      dayOfWeek: json['dayOfWeek'] as int? ?? 0,
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );
  }
}
