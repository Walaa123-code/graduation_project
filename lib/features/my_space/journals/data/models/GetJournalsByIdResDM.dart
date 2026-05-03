import '../../domain/entities/GetJournalByIDResEntity.dart';
import 'JournalDataModel.dart';

class GetJournalByIdResDM extends GetJournalByIdResEntity {
  GetJournalByIdResDM({
    super.success,
    super.message,
    super.data,
    super.errors,
  });

  factory GetJournalByIdResDM.fromJson(Map<String, dynamic> json) {
    return GetJournalByIdResDM(
      success: json['success'],
      message: json['message'],
      data:
          json['data'] != null ? JournalDataDM.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }

}
