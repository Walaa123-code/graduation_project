part of 'schedule_cubit.dart';

abstract class ScheduleState {}

class ScheduleInitialState extends ScheduleState {}

class ScheduleLoadingState extends ScheduleState {}

class ScheduleAddedState extends ScheduleState {
  final ScheduleEntity schedule;
  ScheduleAddedState({required this.schedule});
}

class ScheduleListLoadedState extends ScheduleState {
  final List<ScheduleEntity> schedules;
  ScheduleListLoadedState({required this.schedules});
}

class ScheduleErrorState extends ScheduleState {
  final Failures failure;
  ScheduleErrorState({required this.failure});
}

class ScheduleDeletedState extends ScheduleState {}
