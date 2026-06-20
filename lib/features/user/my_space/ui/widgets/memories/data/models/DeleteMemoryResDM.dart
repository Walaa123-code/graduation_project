import '../../domain/entities/DeleteMemoryResEntity.dart';
import 'DeleteMemoryErrorsDM.dart';

class DeleteMemoryResDM extends DeleteMemoryResEntity {
  DeleteMemoryResDM({
    super.success,
    super.message,
    super.data,
    super.errors,
  });

  factory DeleteMemoryResDM.fromJson(Map<String, dynamic> json) {
    return DeleteMemoryResDM(
      success: json['success'],
      message: json['message'],
      data: json['data'],
      errors: json['errors'] != null
          ? DeleteMemoryErrorsDM.fromJson(json['errors'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;

    if (errors != null) {
      map['errors'] = (errors as DeleteMemoryErrorsDM).toJson();
    }

    return map;
  }
}
