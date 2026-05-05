import 'package:mindecho/features/my_space/journals/domain/entities/DeleteJournalResEntity.dart';
import 'package:mindecho/features/my_space/memories/domain/entities/DeleteMemoryResEntity.dart';

class DeleteMemoryResDM extends DeleteJournalResEntity {
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
      map['errors'] = errors?.toJson();
    }
    return map;
  }
}

class DeleteMemoryErrorsDM extends DeleteMemoryErrorsEntity {
  DeleteMemoryErrorsDM({
    super.key0,
    super.key1,
    super.key2,
    super.key3,
    super.key4,
  });

  DeleteMemoryErrorsDM.fromJson(dynamic json) {
    key0 = json['key_0'] != null ? json['key_0'].cast<String>() : [];
    key1 = json['key_1'] != null ? json['key_1'].cast<String>() : [];
    key2 = json['key_2'] != null ? json['key_2'].cast<String>() : [];
    key3 = json['key_3'] != null ? json['key_3'].cast<String>() : [];
    key4 = json['key_4'] != null ? json['key_4'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key_0'] = key0;
    map['key_1'] = key1;
    map['key_2'] = key2;
    map['key_3'] = key3;
    map['key_4'] = key4;
    return map;
  }
}
