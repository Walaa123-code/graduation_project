import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_constants.dart';
import 'package:mindecho/core/cashe/cashe_helper.dart';

class ApiManager {
  late final Dio dio;

  ApiManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    _addAuthInterceptor();
  }

  /// Attaches Bearer token automatically to every request that needs auth.
  void _addAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await CasheHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Pass the error along; callers handle it individually.
          return handler.next(error);
        },
      ),
    );
  }

  // ───────────────────────────── GET ──────────────────────────────
  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
    );
  }

  // ───────────────────────────── POST (JSON) ──────────────────────
  Future<Response> postData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(
      endPoint,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
      data: body,
    );
  }

  // ───────────────────────────── POST (multipart/form-data) ───────
  Future<Response> postFormData({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(
      endPoint,
      queryParameters: queryParameters,
      options: _mergeOptions(
        Options(contentType: 'multipart/form-data'),
        headers,
      ),
      data: formData,
    );
  }

  // ───────────────────────────── PUT (JSON) ───────────────────────
  Future<Response> putData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.put(
      endPoint,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
      data: body,
    );
  }

  // ───────────────────────────── DELETE ───────────────────────────
  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.delete(
      endPoint,
      queryParameters: queryParameters,
      options: _mergeOptions(options, headers),
    );
  }

  /// Merges extra headers into existing [Options].
  Options _mergeOptions(Options? options, Map<String, dynamic>? headers) {
    final existingHeaders = options?.headers ?? {};
    if (headers != null) {
      existingHeaders.addAll(headers);
    }
    return (options ?? Options()).copyWith(headers: existingHeaders);
  }
}