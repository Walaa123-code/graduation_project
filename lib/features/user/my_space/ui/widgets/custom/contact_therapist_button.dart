import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../../../../appointments/ui/manager/booking_cubit.dart';

/// زرار "Contact Therapist" اللي بيظهر في الـ AppBar بتاع MySpace
/// - لو في confirmed booking: بيبقى solid lavender + chat icon
/// - لو مفيش: بيبقى outlined + person_search icon
class ContactTherapistButton extends StatelessWidget {
  final VoidCallback onTap;

  const ContactTherapistButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final hasConfirmed = state is BookingsLoadedState &&
            state.bookings.any((b) => b.bookingStatus == 1);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: hasConfirmed ? AppColors.lavenderColor : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.lavenderColor, width: 1.5),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  hasConfirmed
                      ? Icons.chat_bubble_outline
                      : Icons.person_search_outlined,
                  color: hasConfirmed ? Colors.white : AppColors.lavenderColor,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Contact therapist',
                  style: hasConfirmed
                      ? AppStyles.bold18Whit.copyWith(fontSize: 14)
                      : AppStyles.bold16Lavender,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
