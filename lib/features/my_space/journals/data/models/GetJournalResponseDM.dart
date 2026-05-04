import '../../domain/entities/GetJournalResponseEntity.dart';
import 'JournalDataModel.dart';

class GetJournalResponseDM extends GetJournalResponseEntity {
  GetJournalResponseDM({
    super.success,
    super.message,
    super.data,
    super.errors,
  });

  factory GetJournalResponseDM.fromJson(Map<String, dynamic> json) {
    return GetJournalResponseDM(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
          .map((v) => JournalDataDM.fromJson(v))
          .toList()
          : null,
      errors: json['errors'],
    );
  }

}