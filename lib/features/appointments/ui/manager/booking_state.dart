part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitialState extends BookingState {}

// Get All Bookings
final class GetAllBookingsLoadingState extends BookingState {}
final class GetAllBookingsSuccessState extends BookingState {
  final GetAllBookingsResponseEntity getAllBookingsResponseEntity;
  GetAllBookingsSuccessState({required this.getAllBookingsResponseEntity});
}
final class GetAllBookingsErrorState extends BookingState {
  final Failures failures;
  GetAllBookingsErrorState({required this.failures});
}

// Create Booking
final class CreateBookingLoadingState extends BookingState {}
final class CreateBookingSuccessState extends BookingState {
  final BookingResponseEntity bookingResponseEntity;
  CreateBookingSuccessState({required this.bookingResponseEntity});
}
final class CreateBookingErrorState extends BookingState {
  final Failures failures;
  CreateBookingErrorState({required this.failures});
}

// Change Status
final class ChangeStatusLoadingState extends BookingState {}
final class ChangeStatusSuccessState extends BookingState {
  final BookingResponseEntity bookingResponseEntity;
  ChangeStatusSuccessState({required this.bookingResponseEntity});
}
final class ChangeStatusErrorState extends BookingState {
  final Failures failures;
  ChangeStatusErrorState({required this.failures});
}
