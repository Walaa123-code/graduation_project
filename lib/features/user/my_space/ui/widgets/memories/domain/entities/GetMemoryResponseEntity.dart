import 'package:mindecho/features/user/my_space/ui/widgets/memories/domain/entities/MemoryDataEntity.dart';

class GetMemoryResponseEntity {
  GetMemoryResponseEntity({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  final bool? success;
 final String? message;
 final List<MemoryDataEntity>? data;
 final dynamic errors;
}
