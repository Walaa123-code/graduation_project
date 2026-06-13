import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/home_tab/data/models/MoodResponseDM.dart';
import 'package:mindecho/features/home_tab/domain/entities/MoodResponseEntity.dart';
import 'package:mindecho/features/home_tab/domain/repositories/data_source/remote_data_source/mood_remote_data_source.dart';
import 'package:injectable/injectable.dart';

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
          endPoint: 'removed', // EndPoints.selectMood,
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
}
