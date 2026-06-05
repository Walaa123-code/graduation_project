import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/login/data/models/login_response_dm.dart';
import 'package:mindecho/features/auth/login/domain/entities/login_response_entity.dart';
import 'login_remote_data_source.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiManager apiManager;
  LoginRemoteDataSourceImpl({required this.apiManager});

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: '/api/Auth/login-user',
          body: {'email': email, 'password': password},
        );
        return Right(LoginResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
