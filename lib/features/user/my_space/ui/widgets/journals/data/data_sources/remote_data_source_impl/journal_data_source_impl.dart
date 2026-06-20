import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import '../../../domain/entities/DeleteJournalResEntity.dart';
import '../../../domain/entities/GetJournalByIDResEntity.dart';
import '../../../domain/entities/GetJournalResponseEntity.dart';
import '../../../domain/repositories/data_source/remote_data_source/journal_data_source.dart';
import '../../models/DeleteJournalResDM.dart';
import '../../models/GetJournalResponseDM.dart';
import '../../models/GetJournalsByIdResDM.dart';

class JournalDataSourceImpl implements JournalDataSource {
  ApiManager apiManager;

  JournalDataSourceImpl({required this.apiManager});
  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, GetJournalResponseEntity>> getJournal() async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getJournal,
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetJournalByIdResEntity>> getJournalById(
      int id) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: "${EndPoints.getJournalById}$id",
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalByIdResDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetJournalByIdResEntity>> createJournal(
      String title, String content) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.createJournal,
          body: {"title": title, "content": content},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalByIdResDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetJournalByIdResEntity>> updateJournal(
      int id, String title, String content) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.updateJournal,
          body: {"title": title, "content": content, "id": id},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalByIdResDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, DeleteJournalResEntity>> deleteJournal(int id) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.deleteData(
          endPoint: "${EndPoints.deleteJournal}$id",
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );

        return Right(DeleteJournalResDm.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
