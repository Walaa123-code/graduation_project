class MoodResponseEntity {
  MoodResponseEntity({
      this.success, 
      this.message, 
      this.data, 
      this.errors,});

  MoodResponseEntity.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }
  bool? success;
  String? message;
  Data? data;
  dynamic errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
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