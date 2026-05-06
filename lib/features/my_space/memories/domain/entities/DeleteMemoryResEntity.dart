
import 'DeleteMemoryErrorsEntity.dart';

class DeleteMemoryResEntity {
  DeleteMemoryResEntity({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  bool? success;
  String? message;
  bool? data;
  DeleteMemoryErrorsEntity? errors;
}


