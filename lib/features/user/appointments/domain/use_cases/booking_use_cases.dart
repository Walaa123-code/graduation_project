import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';

import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository bookingRepository;
  CreateBookingUseCase({required this.bookingRepository});

  Future<Either<Failures, BookingEntity>> call({
    required int doctorSessionSlotId,
  }) =>
      bookingRepository.createBooking(
          doctorSessionSlotId: doctorSessionSlotId);
}

class GetAllBookingsUseCase {
  final BookingRepository bookingRepository;
  GetAllBookingsUseCase({required this.bookingRepository});

  Future<Either<Failures, List<BookingEntity>>> call({
    required bool isDoctor,
  }) =>
      bookingRepository.getAllBookings(isDoctor: isDoctor);
}

class ChangeBookingStatusUseCase {
  final BookingRepository bookingRepository;
  ChangeBookingStatusUseCase({required this.bookingRepository});

  Future<Either<Failures, BookingEntity>> call({
    required int id,
    required int status,
  }) =>
      bookingRepository.changeBookingStatus(id: id, status: status);
}
