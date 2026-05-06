class DeleteJournalResEntity {
  DeleteJournalResEntity({
      this.success, 
      this.message, 
      this.data, 
      this.errors,});

  bool? success;
  String? message;
  bool? data;
  dynamic errors;


}