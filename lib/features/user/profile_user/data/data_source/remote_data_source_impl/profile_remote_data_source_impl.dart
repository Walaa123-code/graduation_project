import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart'; // 🔥 تأكدي من امبورت الـ SharedPreferences
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/user/profile_user/data/models/ProfileResponseDM.dart';
import 'package:mindecho/features/user/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ApiManager apiManager = ApiManager();

  String? _getToken() => SharedPreferencesUtils.getData(key: 'token') as String?;

  @override
  Future<Either<Failures, ProfileResponseDm>> getProfile() async {
    dynamic result = await Connectivity().checkConnectivity();
    bool isConnected = false;

    if (result is List) {
      isConnected = !result.contains(ConnectivityResult.none);
    } else {
      isConnected = result != ConnectivityResult.none;
    }

    if (isConnected) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getProfile, // اللي هو '/api/Client'
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );

        var profileResponse = ProfileResponseDm.fromJson(response.data);
        return Right(profileResponse);

      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      return Left(NetworkError(
          errors: "No internet connection, please check internet"));
    }
  }
}