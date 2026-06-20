import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';
import 'package:mindecho/features/chat/ui/pages/chat_screen.dart';
import 'package:mindecho/features/appointments/ui/manager/booking_cubit.dart';
import '../widgets/message_tile.dart';
import '../models/message_item.dart';

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

  List<MessageItem> _mapBookingsToMessageItems(BookingState state) {
    if (state is BookingsLoadedState) {
      return state.bookings.map((booking) {
        final name = booking.user?.fullName ?? 'Booking #${booking.id}';
        return MessageItem(
          patientName: name,
          lastMessage: 'Tap to view conversation',
          time: '',
          unreadCount: 0,
          isOnline: false,
          initials: name.isNotEmpty ? name[0].toUpperCase() : '?',
          avatarColor: const Color(0xFF4ECDC4),
          bookingId: booking.id,
        );
      }).toList();
    }
    return [];
  }

  List<MessageItem> _filterMessages(List<MessageItem> messages) {
    return messages
        .where((m) =>
            m.patientName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            m.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: AppTheme.spacingXs),
          Expanded(
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                if (state is BookingLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookingErrorState) {
                  return Center(
                    child: Text(
                      'Failed to load conversations: ${state.failure}',
                      style: const TextStyle(color: AppColors.gray500),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final rawMessages = _mapBookingsToMessageItems(state);
                final filteredMessages = _filterMessages(rawMessages);

                if (state is BookingsLoadedState && rawMessages.isEmpty) {
                  return const Center(
                    child: Text(
                      'No conversations available.',
                      style: TextStyle(color: AppColors.gray500),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingXs,
                  ),
                  itemCount: filteredMessages.length,
                  itemBuilder: (context, index) {
                    final message = filteredMessages[index];
                    return MessageTile(
                      message: message,
                      onTap: () => _openChat(context, message),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Opens the SignalR chat screen for the selected conversation.
  /// If [MessageItem.bookingId] is null the tile is not yet linked to a real
  /// booking — a placeholder snackbar is shown instead.
  void _openChat(BuildContext context, MessageItem message) {
    if (message.bookingId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No booking linked to this conversation yet.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          // Factory registration → fresh ChatCubit per navigation
          create: (_) => getIt<ChatCubit>(),
          child: ChatScreen(
            bookingId: message.bookingId!,
            chatPartnerName: message.patientName,
            // Doctor is the current user on this screen
            currentUserSenderType: 1,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        'Messages',
        style: TextStyle(
          color: AppColors.gray800,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune_rounded, color: AppColors.gray600),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.gray100,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: AppTheme.shadowSm,
        ),
        child: TextField(
          onChanged: (v) => setState(() => _searchQuery = v),
          decoration: InputDecoration(
            hintText: 'Search conversations...',
            hintStyle: const TextStyle(color: AppColors.gray400, fontSize: 14),
            prefixIcon:
                const Icon(Icons.search, color: AppColors.gray400, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingMd,
            ),
          ),
        ),
      ),
    );
  }
}
