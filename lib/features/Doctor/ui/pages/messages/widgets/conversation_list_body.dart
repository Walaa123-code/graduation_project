import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import '../../../../../user/appointments/domain/entities/booking_entity.dart';
import '../../../../../user/appointments/ui/manager/booking_cubit.dart';
import 'booking_conversation_tile.dart';
import 'empty_conversations.dart';

class ConversationListBody extends StatelessWidget {
  final String searchQuery;
  final Function(BookingEntity) onConversationTap;

  const ConversationListBody({
    super.key,
    required this.searchQuery,
    required this.onConversationTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is BookingLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.purpleSoft,
            ),
          );
        }

        if (state is BookingErrorState) {
          return AppErrorWidget(
            message: state.failure.errors.toString(),
            onRetry: () => context
                .read<BookingCubit>()
                .getAllBookings(isDoctor: true),
            title: "Couldn't load conversations",
          );
        }

        if (state is BookingsLoadedState) {
          var confirmed = state.bookings
              .where((b) => b.bookingStatus == 1)
              .toList();

          if (searchQuery.isNotEmpty) {
            final q = searchQuery.toLowerCase();
            confirmed = confirmed.where((b) {
              final name = (b.doctor?.fullName ?? b.userId).toLowerCase();
              return name.contains(q);
            }).toList();
          }

          if (confirmed.isEmpty) {
            return EmptyConversations(
              hasSearch: searchQuery.isNotEmpty,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingXs,
            ),
            itemCount: confirmed.length,
            itemBuilder: (context, index) {
              return BookingConversationTile(
                booking: confirmed[index],
                onTap: () => onConversationTap(confirmed[index]),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}