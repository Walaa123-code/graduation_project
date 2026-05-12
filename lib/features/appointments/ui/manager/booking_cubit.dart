import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/BookingResponseEntity.dart';
import '../../domain/entities/GetAllBookingsResponseEntity.dart';
import '../../domain/use_cases/booking_use_case.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingUseCase bookingUseCase;
  BookingCubit({required this.bookingUseCase}) : super(BookingInitialState());

  Future<void> getAllBookings() async {
    emit(GetAllBookingsLoadingState());
    var either = await bookingUseCase.execute();
    either.fold(
      (error) => emit(GetAllBookingsErrorState(failures: error)),
      (response) => emit(
          GetAllBookingsSuccessState(getAllBookingsResponseEntity: response)),
    );
  }

  Future<void> createBooking(int doctorSessionSlotId) async {
    emit(CreateBookingLoadingState());
    var either = await bookingUseCase.invoke(doctorSessionSlotId);
    either.fold(
      (error) => emit(CreateBookingErrorState(failures: error)),
      (response) =>
          emit(CreateBookingSuccessState(bookingResponseEntity: response)),
    );
  }

  Future<void> changeBookingStatus(int id, int status) async {
    emit(ChangeStatusLoadingState());
    var either = await bookingUseCase.call(id, status);
    either.fold(
      (error) => emit(ChangeStatusErrorState(failures: error)),
      (response) =>
          emit(ChangeStatusSuccessState(bookingResponseEntity: response)),
    );
  }
}
