import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../core/api/api_manager.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/cashe/shared_preferences_utils.dart';
import '../../../../../../core/errors/failures.dart';
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
        return Left(ServerError(errors: _handleError(e)));
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
        return Left(ServerError(errors: _handleError(e)));
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
        return Left(ServerError(errors: _handleError(e)));
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
        return Left(ServerError(errors: _handleError(e)));
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
        return Left(ServerError(errors: _handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}

String _handleError(dynamic e) {
  final msg = e.toString();
  if (msg.contains('400')) return "Bad request. Please try again.";
  if (msg.contains('401')) return "Session expired. Please login again.";
  if (msg.contains('403')) return "Access denied.";
  if (msg.contains('404')) return "Data not found.";
  if (msg.contains('500')) return "Server error. Please try later.";
  if (msg.contains('host lookup') || msg.contains('SocketException')) {
    return "Server unreachable. Check your connection.";
  }
  return "Something went wrong. Please try again.";
}
