import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/appointments/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failures, BookingEntity>> createBooking({
    required int doctorSessionSlotId,
  });

  Future<Either<Failures, List<BookingEntity>>> getAllBookings({
    required bool isDoctor,
  });

  Future<Either<Failures, BookingEntity>> changeBookingStatus({
    required int id,
    required int status,
  });
}
