import 'LibraryDateEntity.dart';

class LibraryResponseEntity {
  LibraryResponseEntity({this.success, this.message, this.data, this.errors});
  bool? success;
  String? message;
  List<LibraryDataEntity>? data;
  dynamic errors;
}
