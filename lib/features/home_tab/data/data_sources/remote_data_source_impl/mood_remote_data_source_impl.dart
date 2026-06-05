import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import 'package:mindecho/features/home_tab/data/models/GetAllMoodsResponseDM.dart';
import 'package:mindecho/features/home_tab/data/models/MoodResponseDM.dart';
import 'package:mindecho/features/home_tab/domain/entities/GetAllMoodResponseEntity.dart';
import 'package:mindecho/features/home_tab/domain/entities/MoodResponseEntity.dart';
import 'package:mindecho/features/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final ApiManager apiManager;
  MoodRemoteDataSourceImpl({required this.apiManager});

  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> selectMood(int moodType) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.selectMood,
          body: {"moodType": moodType},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(MoodResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetAllMoodResponseEntity>> getAllMoods() async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getAllMoods,
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetAllMoodsResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> getMoodById(int id) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: "${EndPoints.getMoodById}$id",
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(MoodResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> updateMood(
      int id, int moodType) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.updateMood,
          body: {"id": id, "moodType": moodType},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(MoodResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> deleteMood(int id) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.deleteData(
          endPoint: "${EndPoints.deleteMood}$id",
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(MoodResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
