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

class DeleteMemoryErrorsEntity {
  DeleteMemoryErrorsEntity({
    this.key0,
    this.key1,
    this.key2,
    this.key3,
    this.key4,
  });

  List<String>? key0;
  List<String>? key1;
  List<String>? key2;
  List<String>? key3;
  List<String>? key4;
}
