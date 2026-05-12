import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/BookingResponseEntity.dart';
import '../entities/GetAllBookingsResponseEntity.dart';
import '../repositories/repositories/booking_repository.dart';

class BookingUseCase {
  final BookingRepository bookingRepository;
  BookingUseCase({required this.bookingRepository});

  // Create booking
  Future<Either<Failures, BookingResponseEntity>> invoke(int doctorSessionSlotId) =>
      bookingRepository.createBooking(doctorSessionSlotId);

  // Change booking status
  Future<Either<Failures, BookingResponseEntity>> call(int id, int status) =>
      bookingRepository.changeBookingStatus(id, status);

  // Get all bookings
  Future<Either<Failures, GetAllBookingsResponseEntity>> execute() =>
      bookingRepository.getAllBookings();
}
