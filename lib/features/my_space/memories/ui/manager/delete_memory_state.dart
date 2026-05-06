import 'package:mindecho/features/my_space/memories/domain/entities/DeleteMemoryResEntity.dart';

import '../../../../../core/errors/failures.dart';

sealed class DeleteMemoryState {}

final class DeleteMemoryInitialState extends DeleteMemoryState {}

final class DeleteMemorySuccessState extends DeleteMemoryState {
  final DeleteMemoryResEntity deleteMemoryResEntity;
  DeleteMemorySuccessState({required this.deleteMemoryResEntity});
}

final class DeleteMemoryLoadingState extends DeleteMemoryState {}

final class DeleteMemoryErrorState extends DeleteMemoryState {
  final Failures failures;
  DeleteMemoryErrorState({required this.failures});
}
