import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import '../../../domain/entities/DeleteMemoryResEntity.dart';
import '../../../domain/entities/GetMemoryByIDResEntity.dart';
import '../../../domain/entities/GetMemoryResponseEntity.dart';
import '../../../domain/repositories/data_source/remote_data_source/memory_data_source.dart';
import '../../models/DeleteMemoryResDM.dart';
import '../../models/GetMemoryByIdResDM.dart';
import '../../models/GetMemoryResponseDM.dart';

class MemoryDataSourceImpl implements MemoryDataSource {
  ApiManager apiManager;

  MemoryDataSourceImpl({required this.apiManager});

  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, GetMemoryResponseEntity>> getMemory() async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getMemory,
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetMemoryResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetMemoryByIdResEntity>> getMemoryById(int id) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: "${EndPoints.getMemoryById}$id",
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetMemoryByIdResDm.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetMemoryResponseEntity>> createMemory(
      String title, String moodState, String image) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.createMemory,
          body: {"title": title, "moodState": moodState, "imageUrl": image},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetMemoryResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetMemoryResponseEntity>> updateMemory(
      int id, String title, String moodState, String image) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.updateMemory,
          body: {
            "title": title,
            "id": id,
            "imageUrl": image,
            "moodState": moodState
          },
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetMemoryResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, DeleteMemoryResEntity>> deleteMemory(int id) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.deleteData(
          endPoint: "${EndPoints.deleteMemory}$id",
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(DeleteMemoryResDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
