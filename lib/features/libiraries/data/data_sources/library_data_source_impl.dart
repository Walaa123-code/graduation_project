import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/libiraries/data/models/LibraryResponseDm.dart';
import 'package:mindecho/features/libiraries/domain/entities/LibraryResponseEntity.dart';
import 'package:mindecho/features/libiraries/domain/repositories/data_source/remote_data_source/library_data_source.dart';

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
  if (msg.contains('404')) return "Profile not found.";
  if (msg.contains('500')) return "Server error. Please try later.";
  if (msg.contains('host lookup') || msg.contains('SocketException')) {
    return "Server unreachable. Check your connection.";
  }
  return "Something went wrong. Please try again.";
}
