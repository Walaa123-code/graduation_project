
import '../../domain/entities/DeleteJournalResEntity.dart';

class DeleteJournalResDm extends DeleteJournalResEntity {
  DeleteJournalResDm({
    super.success,
    super.message,
    super.data,
    super.errors,
  });

  factory DeleteJournalResDm.fromJson(Map<String, dynamic> json) {
    return DeleteJournalResDm(
      success: json['success'],
      message: json['message'],
      data: json['data'],
      errors: json['errors'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'errors': errors,
    };
  }
}
