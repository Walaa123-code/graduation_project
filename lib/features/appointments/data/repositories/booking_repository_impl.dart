import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/appointments/data/models/booking_dm.dart';
import 'package:mindecho/features/appointments/domain/entities/booking_entity.dart';
import 'package:mindecho/features/appointments/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final ApiManager apiManager;

  BookingRepositoryImpl({required this.apiManager});

  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  // ── Create Booking (multipart/form-data) ────────────────────────
  @override
  Future<Either<Failures, BookingEntity>> createBooking({
    required int doctorSessionSlotId,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final formData = FormData.fromMap({
        'DoctorSessionSlotId': doctorSessionSlotId.toString(),
      });
      final response = await apiManager.postFormData(
        endPoint: EndPoints.createBooking,
        formData: formData,
      );
      final data = (response.data as Map<String, dynamic>)['data']
          as Map<String, dynamic>? ?? {};
      return Right(BookingDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  // ── Get All Bookings ─────────────────────────────────────────────
  @override
  Future<Either<Failures, List<BookingEntity>>> getAllBookings({
    required bool isDoctor,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response = await apiManager.postData(
        endPoint: EndPoints.getAllBookings,
        queryParameters: {'isDoctor': isDoctor},
      );
      final raw = response.data as Map<String, dynamic>;
      final dataList = raw['data'] as List<dynamic>? ?? [];
      final bookings = dataList
          .map((e) => BookingDM.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(bookings);
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }

  // ── Change Booking Status ────────────────────────────────────────
  @override
  Future<Either<Failures, BookingEntity>> changeBookingStatus({
    required int id,
    required int status,
  }) async {
    if (!await _hasInternet()) {
      return Left(NetworkError(errors: 'No internet connection'));
    }
    try {
      final response = await apiManager.postData(
        endPoint: EndPoints.changeBookingStatus,
        queryParameters: {'Id': id, 'status': status},
      );
      final data = (response.data as Map<String, dynamic>)['data']
          as Map<String, dynamic>? ?? {};
      return Right(BookingDM.fromJson(data));
    } catch (e) {
      return Left(ServerError(errors: e.toString()));
    }
  }
}
