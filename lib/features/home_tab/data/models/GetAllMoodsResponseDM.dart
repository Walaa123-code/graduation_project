class GetAllMoodsResponseDm {
  GetAllMoodsResponseDm({
      this.success, 
      this.message, 
      this.data, 
      this.errors,});

  GetAllMoodsResponseDm.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? success;
  String? message;
  List<Data>? data;
  Errors? errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    return map;
  }

}

class Errors {
  Errors({
      this.key0,});

  Errors.fromJson(dynamic json) {
    key0 = json['key_0'] != null ? json['key_0'].cast<String>() : [];
  }
  List<String>? key0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key_0'] = key0;
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
  int? id;
  int? moodType;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['moodType'] = moodType;
    map['date'] = date;
    return map;
  }

}