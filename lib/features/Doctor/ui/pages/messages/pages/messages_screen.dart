import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';
import 'package:mindecho/features/chat/ui/pages/chat_screen.dart';

import '../../../../../user/appointments/domain/entities/booking_entity.dart';
import '../../../../../user/appointments/ui/manager/booking_cubit.dart';
import '../widgets/conversation_list_body.dart';
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
    context.read<BookingCubit>().getAllBookings(isDoctor: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar:  MessagesAppBar(),
      body: Column(
        children: [
          MessagesSearchBar(
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          const SizedBox(height: AppTheme.spacingXs),
          Expanded(
            child: ConversationListBody(
              searchQuery: _searchQuery,
              onConversationTap: (booking) => _openChat(context, booking),
            ),
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context, BookingEntity booking) {
    final patientName = 'Patient #${booking.userId.length > 6 ? booking.userId.substring(0, 6) : booking.userId}';

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