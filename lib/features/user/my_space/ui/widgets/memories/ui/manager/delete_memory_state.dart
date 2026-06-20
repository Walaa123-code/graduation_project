import 'package:mindecho/features/user/my_space/ui/widgets/memories/domain/entities/DeleteMemoryResEntity.dart';

import 'package:mindecho/core/errors/failures.dart';

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
