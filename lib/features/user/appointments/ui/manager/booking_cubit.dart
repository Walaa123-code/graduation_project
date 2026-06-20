import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/errors/failures.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/use_cases/booking_use_cases.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final CreateBookingUseCase createBookingUseCase;
  final GetAllBookingsUseCase getAllBookingsUseCase;
  final ChangeBookingStatusUseCase changeBookingStatusUseCase;

  BookingCubit({
    required this.createBookingUseCase,
    required this.getAllBookingsUseCase,
    required this.changeBookingStatusUseCase,
  }) : super(BookingInitialState());

  Future<void> createBooking({required int doctorSessionSlotId}) async {
    emit(BookingLoadingState());
    final result = await createBookingUseCase(
        doctorSessionSlotId: doctorSessionSlotId);
    result.fold(
      (failure) => emit(BookingErrorState(failure: failure)),
      (booking) => emit(BookingCreatedState(booking: booking)),
    );
  }

  Future<void> getAllBookings({required bool isDoctor}) async {
    emit(BookingLoadingState());
    final result = await getAllBookingsUseCase(isDoctor: isDoctor);
    result.fold(
      (failure) => emit(BookingErrorState(failure: failure)),
      (bookings) => emit(BookingsLoadedState(bookings: bookings)),
    );
  }

  Future<void> changeBookingStatus({
    required int id,
    required int status,
  }) async {
    emit(BookingLoadingState());
    final result =
        await changeBookingStatusUseCase(id: id, status: status);
    result.fold(
      (failure) => emit(BookingErrorState(failure: failure)),
      (booking) => emit(BookingStatusChangedState(booking: booking)),
    );
  }
}
