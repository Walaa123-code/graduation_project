import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/message_tile.dart';
import '../models/message_item.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<MessageItem> _messages = [
    const MessageItem(
      patientName: 'Ahmed Mohamed',
      lastMessage: 'Doctor, I have been feeling anxious lately...',
      time: '10:32 AM',
      unreadCount: 3,
      isOnline: true,
      initials: 'AM',
      avatarColor: Color(0xFF9B7EBD),
    ),
    const MessageItem(
      patientName: 'Fatima Ali',
      lastMessage: 'Thank you for the prescription, I will start today.',
      time: '9:15 AM',
      unreadCount: 0,
      isOnline: false,
      initials: 'FA',
      avatarColor: Color(0xFF4ECDC4),
    ),
    const MessageItem(
      patientName: 'Omar Hassan',
      lastMessage: 'Can we reschedule our session to Thursday?',
      time: 'Yesterday',
      unreadCount: 1,
      isOnline: true,
      initials: 'OH',
      avatarColor: Color(0xFFFF6B6B),
    ),
    const MessageItem(
      patientName: 'Sara Khalid',
      lastMessage: 'I completed the mindfulness exercises you recommended.',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
      initials: 'SK',
      avatarColor: Color(0xFFFFB84D),
    ),
    const MessageItem(
      patientName: 'Yousef Nasser',
      lastMessage: 'The new medication is working well, thank you!',
      time: 'Monday',
      unreadCount: 0,
      isOnline: false,
      initials: 'YN',
      avatarColor: Color(0xFF56AB2F),
    ),
    const MessageItem(
      patientName: 'Layla Ibrahim',
      lastMessage: 'I have a question about my sleep schedule...',
      time: 'Sunday',
      unreadCount: 2,
      isOnline: true,
      initials: 'LI',
      avatarColor: Color(0xFFA8D8EA),
    ),
  ];

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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
                vertical: AppTheme.spacingXs,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageTile(message: _messages[index]);
              },
            ),
          ),
        ],
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
          icon: const Icon(Icons.search, color: AppColors.gray600),
          onPressed: () {},
        ),
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
