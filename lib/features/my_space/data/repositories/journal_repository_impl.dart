import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/my_space/data/models/journal_dm.dart';
import 'package:mindecho/features/my_space/domain/entities/journal_entity.dart';
import 'package:mindecho/features/my_space/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final ApiManager apiManager;
  JournalRepositoryImpl({required this.apiManager});

  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  Future<Either<Failures, JournalEntity>> createJournal({
    required String title,
    required String content,
    required String date,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final formData = FormData.fromMap({
        'Title': title,
        'Content': content,
        'Date': date,
      });
      final response = await apiManager.postFormData(
        endPoint: EndPoints.createJournal,
        formData: formData,
      );
      final data = (response.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>? ??
          {};
      return Right(JournalDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<JournalEntity>>> getJournals() async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response =
          await apiManager.getData(endPoint: EndPoints.getUserJournals);
      final dataList =
          (response.data as Map<String, dynamic>)['data'] as List<dynamic>? ??
              [];
      final journals = dataList
          .map((e) => JournalDM.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(journals);
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }
}
