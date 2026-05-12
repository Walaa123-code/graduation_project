import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/BookingResponseEntity.dart';
import '../../entities/GetAllBookingsResponseEntity.dart';

abstract class BookingRepository {
  Future<Either<Failures, BookingResponseEntity>> createBooking(int doctorSessionSlotId);
  Future<Either<Failures, BookingResponseEntity>> changeBookingStatus(int id, int status);
  Future<Either<Failures, GetAllBookingsResponseEntity>> getAllBookings();
}
