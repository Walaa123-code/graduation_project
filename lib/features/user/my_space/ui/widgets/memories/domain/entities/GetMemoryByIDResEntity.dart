import 'MemoryDataEntity.dart';

class GetMemoryByIdResEntity {
  GetMemoryByIdResEntity({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  final bool? success;
  final String? message;
  final MemoryDataEntity? data;
  final ErrorsEntity? errors;
}

class ErrorsEntity {
  ErrorsEntity({
    this.key0,
  });

  List<String>? key0;
}
