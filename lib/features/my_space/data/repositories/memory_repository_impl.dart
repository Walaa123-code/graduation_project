import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/data/models/memory_dm.dart';
import 'package:mindecho/features/my_space/domain/entities/memory_entity.dart';
import 'package:mindecho/features/my_space/domain/repositories/memory_repository.dart';

class MemoryRepositoryImpl implements MemoryRepository {
  final ApiManager apiManager;

  MemoryRepositoryImpl({required this.apiManager});

  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  Future<Either<Failures, MemoryEntity>> createMemory({
    required int moodState,
    required String title,
    String? imagePath,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final fields = <String, dynamic>{
        'MoodState': moodState.toString(),
        'Title': title,
      };
      if (imagePath != null) {
        fields['Image'] = await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        );
      }
      final formData = FormData.fromMap(fields);
      final response = await apiManager.postFormData(
        endPoint: EndPoints.createMemory,
        formData: formData,
      );
      final data = (response.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>? ??
          {};
      return Right(MemoryDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<MemoryEntity>>> getMemories() async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response = await apiManager.getData(endPoint: EndPoints.getMemories);
      final dataList =
          (response.data as Map<String, dynamic>)['data'] as List<dynamic>? ??
              [];
      final memories = dataList
          .map((e) => MemoryDM.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(memories);
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }
}
