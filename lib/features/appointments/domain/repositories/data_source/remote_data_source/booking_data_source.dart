import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../entities/BookingResponseEntity.dart';
import '../../../entities/GetAllBookingsResponseEntity.dart';

abstract class BookingDataSource {
  Future<Either<Failures, BookingResponseEntity>> createBooking(int doctorSessionSlotId);
  Future<Either<Failures, BookingResponseEntity>> changeBookingStatus({required int id, required int status});
  Future<Either<Failures, GetAllBookingsResponseEntity>> getAllBookings({required bool isDoctor});
}
