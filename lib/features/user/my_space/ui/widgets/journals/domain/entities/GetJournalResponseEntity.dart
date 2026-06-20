import 'JournalDataEntity.dart';

class GetJournalResponseEntity {
  final bool? success;
  final String? message;
  final List<JournalDataEntity>? data;
  final dynamic errors;


  GetJournalResponseEntity({
    this.success,
    this.message,
    this.data,
    this.errors,
  });
}
