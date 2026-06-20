import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';
import 'package:mindecho/features/chat/ui/pages/chat_screen.dart';

import '../../../../../user/appointments/domain/entities/booking_entity.dart';
import '../../../../../user/appointments/ui/manager/booking_cubit.dart';
import '../widgets/messages_app_bar.dart';
import '../widgets/messages_search_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // جلب الحجوزات الخاصة بالطبيب عند فتح الشاشة
    context.read<BookingCubit>().getAllBookings(isDoctor: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: MessagesAppBar(),
      body: Column(
        children: [
          MessagesSearchBar(
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          const SizedBox(height: AppTheme.spacingXs),
          Expanded(
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                // ── حالة التحميل (Loading) ──────────────────────────────────────
                if (state is BookingLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.purpleSoft,
                    ),
                  );
                }

                // ── حالة الخطأ (Error) ────────────────────────────────────────
                if (state is BookingErrorState) {
                  return AppErrorWidget(
                    message: state.failure.errors.toString(),
                    onRetry: () => context
                        .read<BookingCubit>()
                        .getAllBookings(isDoctor: true),
                    title: "Couldn't load conversations",
                  );
                }

                // ── حالة النجاح وتحميل البيانات (Loaded) ───────────────────────────
                if (state is BookingsLoadedState) {
                  // فلترة الحجوزات المؤكدة فقط (status == 1)
                  var confirmed = state.bookings
                      .where((b) => b.bookingStatus == 1)
                      .toList();

                  // فلترة البحث لو النص مش فاضي
                  if (_searchQuery.isNotEmpty) {
                    final q = _searchQuery.toLowerCase();
                    confirmed = confirmed.where((b) {
                      final name =
                          (b.doctor?.fullName ?? b.userId).toLowerCase();
                      return name.contains(q);
                    }).toList();
                  }

                  // لو مفيش محادثات مؤكدة أو متوافقة مع البحث
                  if (confirmed.isEmpty) {
                    return _EmptyConversations(
                      hasSearch: _searchQuery.isNotEmpty,
                    );
                  }

                  // عرض لستة المحادثات
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingXs,
                    ),
                    itemCount: confirmed.length,
                    itemBuilder: (context, index) {
                      return _BookingConversationTile(
                        booking: confirmed[index],
                        onTap: () => _openChat(context, confirmed[index]),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context, BookingEntity booking) {
    final patientName =
        'Patient #${booking.userId.length > 6 ? booking.userId.substring(0, 6) : booking.userId}';

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<ChatCubit>(),
          child: ChatScreen(
            bookingId: booking.id,
            doctorId: booking.doctorId,
            chatPartnerName: patientName,
            currentUserSenderType: 1, // 1 = Doctor
          ),
        ),
      ),
    );
  }
}

// ── Conversation tile built from real booking data ───────────────────────────

class _BookingConversationTile extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback onTap;

  const _BookingConversationTile({
    required this.booking,
    required this.onTap,
  });

  String get _patientInitials {
    final id = booking.userId;
    return id.length >= 2 ? id.substring(0, 2).toUpperCase() : id.toUpperCase();
  }

  String get _patientName =>
      'Patient #${booking.userId.length > 6 ? booking.userId.substring(0, 6) : booking.userId}';

  String get _subtitle =>
      'Session #${booking.doctorSessionSlotId} • Tap to chat';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.purpleBg,
          child: Text(
            _patientInitials,
            style: const TextStyle(
              color: AppColors.purpleSoft,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        title: Text(
          _patientName,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.gray800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            _subtitle,
            style: const TextStyle(fontSize: 13, color: AppColors.gray500),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.purpleBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Confirmed',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.purpleSoft,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────────

class _EmptyConversations extends StatelessWidget {
  final bool hasSearch;
  const _EmptyConversations({required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.purpleBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48,
              color: AppColors.purpleSoft,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            hasSearch ? 'No results found' : 'No conversations yet',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasSearch
                ? 'Try a different search'
                : 'Confirmed bookings will appear here',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.gray500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
