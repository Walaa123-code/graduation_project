import '../../domain/entities/LibraryResponseEntity.dart';
import 'LibraryDataDM.dart';

class LibraryResponseDm extends LibraryResponseEntity {
  LibraryResponseDm({super.success, super.message, super.data, super.errors});

  factory LibraryResponseDm.fromJson(dynamic json) {
    return LibraryResponseDm(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((v) => LibraryDataDM.fromJson(v))
              .toList()
          : null,
      errors: json['errors'],
    );
  }
}
