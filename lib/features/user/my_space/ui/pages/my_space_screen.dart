import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';
import 'package:mindecho/features/chat/ui/pages/chat_screen.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import '../../../appointments/ui/manager/booking_cubit.dart';
import '../widgets/custom/contact_therapist_button.dart';
import '../widgets/journals/ui/manager/delete_journal_cubit.dart';
import '../widgets/journals/ui/manager/journal_cubit.dart';
import '../widgets/journals/ui/pages/journals_tab.dart';
import '../widgets/memories/ui/manager/delete_memory_cubit.dart';
import '../widgets/memories/ui/manager/memory_cubit.dart';
import '../widgets/memories/ui/pages/memories_tab.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  void _handleContactTherapist(BuildContext context) {
    final bookingState = context.read<BookingCubit>().state;

    if (bookingState is BookingsLoadedState) {
      final confirmed = bookingState.bookings
          .where((b) => b.bookingStatus == 1)
          .toList();

      if (confirmed.isEmpty) {
        final hasPending =
        bookingState.bookings.any((b) => b.bookingStatus == 0);
        _showNoBookingDialog(context, hasPending: hasPending);
        return;
      }

      final booking = confirmed.first;
      final doctorName = booking.doctor?.fullName ??
          'Dr. ${booking.doctorId.substring(0, 8)}...';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ChatCubit>(),
            child: ChatScreen(
              bookingId: booking.id,
              doctorId: booking.doctorId,
              chatPartnerName: doctorName,
              currentUserSenderType: 0,
            ),
          ),
        ),
      );
    } else {
      context.read<BookingCubit>().getAllBookings(isDoctor: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Loading your bookings, please try again...'),
          backgroundColor: AppColors.lavenderColor,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _showNoBookingDialog(BuildContext context, {required bool hasPending}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.lavenderColor),
            const SizedBox(width: 8),
            Text(
              hasPending ? 'Booking Pending' : 'No Active Booking',
              style: AppStyles.bold20Black,
            ),
          ],
        ),
        content: Text(
          hasPending
              ? 'Your booking request is still pending.\nYou can chat with your doctor once confirmed.'
              : 'You need to book a session first.\n\nGo to the Appointments tab.',
          style: AppStyles.medium16Gray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK',
                style: TextStyle(
                    color: AppColors.lavenderColor,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<JournalCubit>()..getJournal()),
          BlocProvider(create: (context) => getIt<DeleteJournalCubit>()),
          BlocProvider(create: (context) => getIt<MemoryCubit>()..getMemory()),
          BlocProvider(create: (context) => getIt<DeleteMemoryCubit>()),
        ],
        child: Builder( // الـ Builder ده عشان نضمن إن الـ context يقدر يقرأ الـ Cubits اللي فوقيه
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: true,
                  titleSpacing: 0.0,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Space',
                          style: AppStyles.bold25Black,
                        ),
                        ContactTherapistButton(
                          onTap: () => _handleContactTherapist(context),
                        ),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    labelStyle: AppStyles.bold20Lavender,
                    unselectedLabelStyle: AppStyles.bold18Black,
                    indicatorColor: AppColors.lavenderColor,
                    labelColor: AppColors.lavenderColor,
                    unselectedLabelColor: AppColors.blackColor,
                    tabs: const [
                      Tab(text: 'Journals'),
                      Tab(text: 'Memories'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    // 🔥 باصينا الـ Cubit الحالي هنا بشكل مباشر عشان نربطه بصفحة الـ Journals تماماً
                    JournalsTab(journalCubit: context.read<JournalCubit>()),
                    const MemoriesTab(),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}