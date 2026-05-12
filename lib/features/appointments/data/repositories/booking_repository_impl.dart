import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/appointments/domain/entities/BookingResponseEntity.dart';
import 'package:mindecho/features/appointments/domain/entities/GetAllBookingsResponseEntity.dart';
import 'package:mindecho/features/appointments/domain/repositories/data_source/remote_data_source/booking_data_source.dart';
import 'package:mindecho/features/appointments/domain/repositories/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDataSource bookingDataSource;
  BookingRepositoryImpl({required this.bookingDataSource});

  @override
  Future<Either<Failures, BookingResponseEntity>> createBooking(
      int doctorSessionSlotId) async {
    var either = await bookingDataSource.createBooking(doctorSessionSlotId);
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, BookingResponseEntity>> changeBookingStatus(
      int id, int status) async {
    var either = await bookingDataSource.changeBookingStatus(id, status);
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, GetAllBookingsResponseEntity>>
      getAllBookings() async {
    var either = await bookingDataSource.getAllBookings();
    return either.fold((e) => left(e), (r) => right(r));
  }
}
