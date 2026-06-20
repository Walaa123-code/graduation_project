import 'package:flutter/material.dart';

import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/GetMemoryResponseEntity.dart';

@immutable
sealed class UpdateMemoryState {}

final class UpdateMemoryInitialState extends UpdateMemoryState {}

final class UpdateMemoryLoadingState extends UpdateMemoryState {}

final class UpdateMemorySuccessState extends UpdateMemoryState {
  final GetMemoryResponseEntity response;
  UpdateMemorySuccessState({required this.response});
}

final class UpdateMemoryErrorState extends UpdateMemoryState {
  final Failures failures;
  UpdateMemoryErrorState({required this.failures});
}
