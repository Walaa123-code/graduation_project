part of 'schedule_cubit.dart';

abstract class ScheduleState {}

class ScheduleInitialState extends ScheduleState {}

class ScheduleLoadingState extends ScheduleState {}

class ScheduleAddedState extends ScheduleState {
  final ScheduleEntity schedule;
  ScheduleAddedState({required this.schedule});
}

class ScheduleErrorState extends ScheduleState {
  final Failures failure;
  ScheduleErrorState({required this.failure});
}
