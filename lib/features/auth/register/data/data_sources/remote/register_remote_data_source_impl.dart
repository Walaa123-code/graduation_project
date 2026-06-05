import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/register/data/models/register_response_dm.dart';
import 'package:mindecho/features/auth/register/domain/entities/register_response_entity.dart';
import 'register_remote_data_source.dart';

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiManager apiManager;
  RegisterRemoteDataSourceImpl({required this.apiManager});

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, RegisterResponseEntity>> register(
      String name, String email, String password) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: '/api/Auth/register-user',
          body: {
            'userName': name,
            'email': email,
            'password': password,
            'confirmPassword': password,
          },
        );
        return Right(RegisterResponseDM.fromJson(response.data));      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
