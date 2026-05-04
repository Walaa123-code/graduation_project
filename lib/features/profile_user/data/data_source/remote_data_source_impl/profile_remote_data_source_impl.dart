import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/profile_user/data/models/ProfileResponseDM.dart';
import 'package:mindecho/features/profile_user/domain/repositories/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, ProfileResponseDm>> getProfile() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // todo internet
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.getProfile,
        );
        var profileResponse = ProfileResponseDm.fromJson(response.data);

        return Right(profileResponse);
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    } else {
      // todo no internet
      return Left(NetworkError(
          errors: "No internet connection, please check internet"));
    }
  }
}
