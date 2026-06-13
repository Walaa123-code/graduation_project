import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import 'package:mindecho/features/appointments/data/models/BookingResponseDM.dart';
import 'package:mindecho/features/appointments/data/models/GetAllBookingsResponseDM.dart';
import 'package:mindecho/features/appointments/domain/entities/BookingResponseEntity.dart';
import 'package:mindecho/features/appointments/domain/entities/GetAllBookingsResponseEntity.dart';
import 'package:mindecho/features/appointments/domain/repositories/data_source/remote_data_source/booking_data_source.dart';

class BookingDataSourceImpl implements BookingDataSource {
  final ApiManager apiManager;
  BookingDataSourceImpl({required this.apiManager});

  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, BookingResponseEntity>> createBooking(
      int doctorSessionSlotId) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.createBooking,
          body: {"doctorSessionSlotId": doctorSessionSlotId},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(BookingResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, BookingResponseEntity>> changeBookingStatus(
      {required int id, required int status}) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.changeBookingStatus,
          body: {'Id': id, 'status': status},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(BookingResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, GetAllBookingsResponseEntity>>
      getAllBookings({required bool isDoctor}) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.getAllBookings,
          queryParameters: {'isDoctor': isDoctor},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(GetAllBookingsResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
