part of 'booking_cubit.dart';

abstract class BookingState {}

class BookingInitialState extends BookingState {}

class BookingLoadingState extends BookingState {}

class BookingCreatedState extends BookingState {
  final BookingEntity booking;
  BookingCreatedState({required this.booking});
}

class BookingsLoadedState extends BookingState {
  final List<BookingEntity> bookings;
  BookingsLoadedState({required this.bookings});
}

class BookingStatusChangedState extends BookingState {
  final BookingEntity booking;
  BookingStatusChangedState({required this.booking});
}

class BookingErrorState extends BookingState {
  final Failures failure;
  BookingErrorState({required this.failure});
}
