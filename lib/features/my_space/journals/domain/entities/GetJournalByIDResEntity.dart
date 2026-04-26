import 'JournalDataEntity.dart';

class GetJournalByIdResEntity {
  final bool? success;
  final String? message;
  final JournalDataEntity? data;
  final dynamic errors;

  GetJournalByIdResEntity({
    this.success,
    this.message,
    this.data,
    this.errors,
  });
}