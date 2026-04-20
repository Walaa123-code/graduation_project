import 'package:dio/dio.dart';
import 'package:graduation_project/core/api/api_constants.dart';

class ApiManager {
  Dio dio = Dio();

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      ApiConstants.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> postData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(
      ApiConstants.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      data: body,
    );
  }
}