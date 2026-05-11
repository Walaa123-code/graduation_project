class GetAllMoodResponseEntity {
  GetAllMoodResponseEntity({
      this.success, 
      this.message, 
      this.data, 
      this.errors,});

  GetAllMoodResponseEntity.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    errors = json['errors'];
  }
  bool? success;
  String? message;
  List<Data>? data;
  dynamic errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['errors'] = errors;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.moodType, 
      this.date,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    moodType = json['moodType'];
    date = json['date'];
  }
  num? id;
  num? moodType;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['moodType'] = moodType;
    map['date'] = date;
    return map;
  }

}