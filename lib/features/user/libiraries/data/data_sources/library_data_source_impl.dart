import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import 'package:mindecho/features/user/libiraries/data/models/LibraryResponseDm.dart';
import 'package:mindecho/features/user/libiraries/domain/entities/LibraryResponseEntity.dart';
import 'package:mindecho/features/user/libiraries/domain/repositories/data_source/remote_data_source/library_data_source.dart';

class LibraryDataSourceImpl implements LibraryDateSource {
  final ApiManager apiManager;
  LibraryDataSourceImpl({required this.apiManager});

  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, LibraryResponseEntity>> getLibrary(int mood) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getLibrary,
          queryParameters: {'libraryMood': mood},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(LibraryResponseDm.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
