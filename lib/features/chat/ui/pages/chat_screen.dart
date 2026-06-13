import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';
import 'package:mindecho/features/chat/ui/widgets/chat_bubble.dart';

/// Chat screen for a single booking conversation.
///
/// Lifecycle:
///   initState → cubit.initChat(bookingId)
///     → hub connects, JoinChat invoked, LoadMessages requested
///   dispose  → cubit.close() is called automatically by BlocProvider
///
/// [currentUserSenderType] must be provided by the caller:
///   0 = patient/user is the current user
///   1 = doctor is the current user
class ChatScreen extends StatefulWidget {
  final int bookingId;
  final String chatPartnerName;

  /// Sender type of the currently logged-in user.
  /// 0 = User (patient), 1 = Doctor.
  final int currentUserSenderType;

  const ChatScreen({
    super.key,
    required this.bookingId,
    required this.chatPartnerName,
    required this.currentUserSenderType,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().initChat(widget.bookingId);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final content = _inputController.text.trim();
    if (content.isEmpty) return;
    _inputController.clear();
    final cubit = context.read<ChatCubit>();
    cubit.sendMessage(widget.bookingId, content, widget.currentUserSenderType);
    // Mark other side's existing messages as read after sending
    cubit.markAsRead(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // ── Connection status banner ───────────────────────────
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (prev, curr) => curr is ChatLoadedState,
            builder: (context, state) {
              if (state is ChatLoadedState &&
                  state.connectionState != ChatConnectionState.connected) {
                return _buildConnectionBanner(state.connectionState);
              }
              return const SizedBox.shrink();
            },
          ),

          // ── Main content ───────────────────────────────────────
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is BookingStatusUpdatedState) {
                  _showBookingStatusSnackBar(context, state);
                }
                if (state is ChatLoadedState) {
                  _scrollToBottom();
                  // Mark as read when new messages arrive
                  context.read<ChatCubit>().markAsRead(widget.bookingId);
                  // Show send error if any
                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                        backgroundColor: Colors.red.shade400,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is ChatInitialState ||
                    (state is ChatLoadedState &&
                        state.connectionState ==
                            ChatConnectionState.connecting &&
                        state.messages.isEmpty)) {
                  return _buildLoadingIndicator();
                }

                if (state is ChatErrorState) {
                  return _buildErrorView(state.message);
                }

                if (state is ChatLoadedState) {
                  return _buildMessageList(state);
                }

                // BookingStatusUpdatedState is handled by listener;
                // preserve current UI by returning an empty container.
                return const SizedBox.shrink();
              },
            ),
          ),

          // ── Input bar ──────────────────────────────────────────
          _buildInputBar(),
        ],
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.gray700, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.purpleBg,
            child: Text(
              widget.chatPartnerName.isNotEmpty
                  ? widget.chatPartnerName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatPartnerName,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // Connection state subtitle
                BlocBuilder<ChatCubit, ChatState>(
                  buildWhen: (p, c) => c is ChatLoadedState,
                  builder: (context, state) {
                    final label = _connectionLabel(state);
                    if (label == null) return const SizedBox.shrink();
                    return Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: _connectionLabelColor(state),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.gray100),
      ),
    );
  }

  String? _connectionLabel(ChatState state) {
    if (state is! ChatLoadedState) return null;
    switch (state.connectionState) {
      case ChatConnectionState.connecting:
        return 'Connecting…';
      case ChatConnectionState.reconnecting:
        return 'Reconnecting…';
      case ChatConnectionState.disconnected:
        return 'Disconnected';
      case ChatConnectionState.error:
        return 'Connection error';
      case ChatConnectionState.connected:
        return null;
    }
  }

  Color _connectionLabelColor(ChatState state) {
    if (state is! ChatLoadedState) return AppColors.gray400;
    switch (state.connectionState) {
      case ChatConnectionState.connected:
        return const Color(0xFF48BB78); // green
      case ChatConnectionState.reconnecting:
        return AppColors.accentOrange;
      case ChatConnectionState.error:
      case ChatConnectionState.disconnected:
        return Colors.red.shade400;
      case ChatConnectionState.connecting:
        return AppColors.gray400;
    }
  }

  // ── Connection banner ────────────────────────────────────────────

  Widget _buildConnectionBanner(ChatConnectionState connState) {
    String text;
    Color bg;
    switch (connState) {
      case ChatConnectionState.connecting:
        text = 'Connecting to chat…';
        bg = AppColors.gray300;
        break;
      case ChatConnectionState.reconnecting:
        text = 'Connection lost — reconnecting…';
        bg = AppColors.accentOrange;
        break;
      case ChatConnectionState.disconnected:
        text = 'Disconnected';
        bg = AppColors.gray500;
        break;
      case ChatConnectionState.error:
        text = 'Connection error';
        bg = Colors.red.shade400;
        break;
      default:
        return const SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.spacingXs,
        horizontal: AppTheme.spacingMd,
      ),
      color: bg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: AppTheme.spacingXs),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Message list ─────────────────────────────────────────────────

  Widget _buildMessageList(ChatLoadedState state) {
    if (state.messages.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline_rounded,
                size: 56, color: AppColors.gray300),
            SizedBox(height: AppTheme.spacingMd),
            Text(
              'No messages yet.\nSay hello!',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.gray400, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingMd,
      ),
      itemCount: state.messages.length + (state.seenByOther ? 1 : 0),
      itemBuilder: (context, index) {
        // Seen indicator at the bottom
        if (state.seenByOther && index == state.messages.length) {
          return _buildSeenIndicator();
        }
        final msg = state.messages[index];
        final isOutgoing =
            msg.messageSenderType == widget.currentUserSenderType;
        return ChatBubble(message: msg, isOutgoing: isOutgoing);
      },
    );
  }

  Widget _buildSeenIndicator() {
    return const Padding(
      padding: EdgeInsets.only(right: AppTheme.spacingXs, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.done_all_rounded,
              size: 14, color: AppColors.primary),
          SizedBox(width: 4),
          Text(
            'Seen',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Loading & error ──────────────────────────────────────────────

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: AppTheme.spacingMd),
          Text(
            'Connecting to chat…',
            style: TextStyle(color: AppColors.gray400, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 56, color: AppColors.gray300),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.gray500, fontSize: 15),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<ChatCubit>().initChat(widget.bookingId),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Input bar ────────────────────────────────────────────────────

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: AppTheme.spacingMd,
        right: AppTheme.spacingMd,
        top: AppTheme.spacingSm,
        bottom: AppTheme.spacingSm +
            MediaQuery.of(context).viewInsets.bottom.clamp(0.0, 0.0),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.gray100),
        ),
        boxShadow: AppTheme.shadowSm,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  border: Border.all(color: AppColors.gray200),
                ),
                child: TextField(
                  controller: _inputController,
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Type a message…',
                    hintStyle:
                        TextStyle(color: AppColors.gray400, fontSize: 15),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingSm),
            // Send button
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: AppTheme.shadowPurple,
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Booking status SnackBar ──────────────────────────────────────

  void _showBookingStatusSnackBar(
      BuildContext context, BookingStatusUpdatedState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                color: AppColors.white, size: 18),
            const SizedBox(width: AppTheme.spacingXs),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking ${state.status.status}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  if (state.status.message.isNotEmpty)
                    Text(
                      state.status.message,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppTheme.spacingMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
