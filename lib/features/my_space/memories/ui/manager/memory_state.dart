
import 'package:flutter/material.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/GetMemoryByIDResEntity.dart';
import '../../domain/entities/GetMemoryResponseEntity.dart';

@immutable
sealed class MemoryState {}

final class GetMemoryInitialState extends MemoryState {}

final class GetMemorySuccessState extends MemoryState {
  final GetMemoryResponseEntity getMemoryResponseEntity;
  GetMemorySuccessState({required this.getMemoryResponseEntity});
}

final class GetMemoryLoadingState extends MemoryState {}

final class GetMemoryErrorState extends MemoryState {
  final Failures failures;
  GetMemoryErrorState({required this.failures});
}

// get JournalId
final class GetMemoryByIdSuccessState extends MemoryState {
  final GetMemoryByIdResEntity getMemoryByIdResEntity;
  GetMemoryByIdSuccessState({required this.getMemoryByIdResEntity});
}

final class GetMemoryByIdLoadingState extends MemoryState {}
