class DataResponseEntity {
  DataResponseEntity({
    this.id,
    this.moodType,
    this.date,});

  DataResponseEntity.fromJson(dynamic json) {
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