import '../../domain/entities/GetMemoryByIDResEntity.dart';
import 'MemoryDataModel.dart';

class GetMemoryByIdResDm extends GetMemoryByIdResEntity {
  GetMemoryByIdResDm({
    super.success,
    super.message,
    super.data,
    super.errors,
  });

  factory GetMemoryByIdResDm.fromJson(Map<String, dynamic> json) {
    return GetMemoryByIdResDm(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? MemoryDataDM.fromJson(json['data']) : null,
      errors:
          json['errors'] != null ? ErrorsModel.fromJson(json['errors']) : null,
    );
  }
}

class ErrorsModel extends ErrorsEntity {
  ErrorsModel({
    super.key0,
  });

  ErrorsModel.fromJson(dynamic json) {
    key0 = json['key_0'] != null ? json['key_0'].cast<String>() : [];
  }
}
