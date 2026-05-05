import 'package:mindecho/features/my_space/memories/domain/entities/GetMemoryResponseEntity.dart';

import 'MemoryDataModel.dart';

class GetMemoryResponseDM extends GetMemoryResponseEntity {
  GetMemoryResponseDM({
      super.success,
      super.message,
      super.data,
      super.errors,});

 factory GetMemoryResponseDM.fromJson(Map<String, dynamic> json) {
   return GetMemoryResponseDM(
       success : json['success'],
       message : json['message'],
       data: json['data'] != null
           ? (json['data'] as List)
           .map((v) => MemoryDataDM.fromJson(v))
           .toList()
           : null,
       errors: json['errors']);

  }



}

