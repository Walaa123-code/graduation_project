import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/cashe_helper.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/auth/data/models/auth_response_dm.dart';
import 'package:mindecho/features/auth/domain/entities/auth_entity.dart';
import 'package:mindecho/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiManager apiManager;

  AuthRepositoryImpl({required this.apiManager});

  // ── Connectivity helper ─────────────────────────────────────────
  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  /// Shared helper: POST, parse, save token, return entity.
  Future<Either<Failures, AuthEntity>> _authPost({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response = await apiManager.postData(
        endPoint: endpoint,
        body: body,
      );
      final dm = AuthResponseDM.fromJson(response.data as Map<String, dynamic>);
      if (dm.token.isNotEmpty) {
        await CasheHelper.saveToken(dm.token);
      }
      return Right(dm);
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  // ── Register User ───────────────────────────────────────────────
  @override
  Future<Either<Failures, AuthEntity>> registerUser({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
  }) =>
      _authPost(
        endpoint: EndPoints.registerUser,
        body: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'gender': gender,
          'age': age,
        },
      );

  // ── Login User ──────────────────────────────────────────────────
  @override
  Future<Either<Failures, AuthEntity>> loginUser({
    required String email,
    required String password,
  }) =>
      _authPost(
        endpoint: EndPoints.loginUser,
        body: {'email': email, 'password': password},
      );

  // ── Register Doctor ─────────────────────────────────────────────
  @override
  Future<Either<Failures, AuthEntity>> registerDoctor({
    required String fullName,
    required String email,
    required String password,
    required int gender,
    required int age,
    required String licenseNumber,
    required String specialization,
    required String bio,
  }) =>
      _authPost(
        endpoint: EndPoints.registerDoctor,
        body: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'gender': gender,
          'age': age,
          'licenseNumber': licenseNumber,
          'specialization': specialization,
          'bio': bio,
        },
      );

  // ── Login Doctor ────────────────────────────────────────────────
  @override
  Future<Either<Failures, AuthEntity>> loginDoctor({
    required String email,
    required String password,
  }) =>
      _authPost(
        endpoint: EndPoints.loginDoctor,
        body: {'email': email, 'password': password},
      );
}
