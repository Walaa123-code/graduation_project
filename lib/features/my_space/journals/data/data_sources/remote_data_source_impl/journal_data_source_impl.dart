import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/api/api_manager.dart';
import 'package:graduation_project/core/api/end_points.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/my_space/journals/data/models/DeleteJournalResDM.dart';
import 'package:graduation_project/features/my_space/journals/data/models/GetJournalResponseDM.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/DeleteJournalResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/entities/GetJournalByIDResEntity.dart';
import 'package:graduation_project/features/my_space/journals/domain/repositories/data_source/remote_data_source/journal_data_source.dart';

import '../../../../../../core/cashe/shared_preferences_utils.dart';
import '../../models/GetJournalsByIdResDM.dart';

class JournalDataSourceImpl implements JournalDataSource {
  ApiManager apiManager;

  JournalDataSourceImpl({required this.apiManager});

  // 1. دالة التوكن (اللي إنتِ عملتيها)
  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  // 2. دالة التحقق من الاتصال (بتلم كل الزحمة اللي فوق)
  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, GetJournalResponseDM>> getJournal() async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getJournal,
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
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
        return Left(ServerError(errors: e.toString()));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
  @override
  Future<Either<Failures, GetJournalByIdResEntity>> createJournal(String title,
      String content) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.createJournal,
          body: {"title": title, "content": content},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalByIdResDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetJournalByIdResEntity>> updateJournal(int id,
      String title, String content) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.updateJournal,
          body: {"Title": title, "Content": content, "Id": id},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetJournalByIdResDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: e.toString()));
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
        return Left(ServerError(errors: e.toString()));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
