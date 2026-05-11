class LibraryResponseEntity {
  LibraryResponseEntity({
      this.success, 
      this.message, 
      this.data, 
      this.errors,});

  LibraryResponseEntity.fromJson(dynamic json) {
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
      this.title, 
      this.imageUrl, 
      this.contentUrl, 
      this.type, 
      this.mood,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    contentUrl = json['contentUrl'];
    type = json['type'];
    mood = json['mood'];
  }
  num? id;
  String? title;
  String? imageUrl;
  String? contentUrl;
  num? type;
  num? mood;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['imageUrl'] = imageUrl;
    map['contentUrl'] = contentUrl;
    map['type'] = type;
    map['mood'] = mood;
    return map;
  }

}