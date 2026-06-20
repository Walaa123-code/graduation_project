import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/user/home_tab/data/models/MoodResponseDM.dart';
import 'package:mindecho/features/user/home_tab/domain/entities/MoodResponseEntity.dart';
import 'package:mindecho/features/user/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/GetAllMoodResponseEntity.dart';
import '../../models/GetAllMoodsResponseDM.dart';

@Injectable(as: MoodRemoteDataSource)
class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final ApiManager apiManager;
  MoodRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, MoodResponseEntity>> selectMood(int id) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // todo internet
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.selectMood,
          body: {
            "moodType": id,
          },
        );
        var moodResponse = MoodResponseDM.fromJson(response.data);

        return Right(moodResponse);
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      return Left(NetworkError(errors: "No internet connection"));
    }
  }

  @override
  Future<Either<Failures, GetAllMoodResponseEntity>> getAllMoods() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getAllMoods,
        );
        var moodsResponse = GetAllMoodsResponseDM.fromJson(response.data);
        return Right(moodsResponse);
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      return Left(NetworkError(errors: "No internet connection"));
    }
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> getMoodById(int id) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        var response = await apiManager.getData(
          endPoint: "${EndPoints.getMoodById}$id",
        );
        var moodResponse = MoodResponseDM.fromJson(response.data);
        return Right(moodResponse);
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      return Left(NetworkError(errors: "No internet connection"));
    }
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> updateMood(int id, int moodType) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        var response = await apiManager.putData(
          endPoint: "${EndPoints.updateMood}$id",
          body: {
            "moodType": moodType,
          },
        );
        var moodResponse = MoodResponseDM.fromJson(response.data);
        return Right(moodResponse);
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      return Left(NetworkError(errors: "No internet connection"));
    }
  }

  @override
  Future<Either<Failures, MoodResponseEntity>> deleteMood(int id) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        var response = await apiManager.deleteData(
          endPoint: "${EndPoints.deleteMood}$id",
        );
        var moodResponse = MoodResponseDM.fromJson(response.data);
        return Right(moodResponse);
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      return Left(NetworkError(errors: "No internet connection"));
    }
  }
}
