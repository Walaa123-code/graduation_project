import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';

import '../widgets/chat_app_bar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/connection_banner.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/message_list.dart';

class ChatScreen extends StatefulWidget {
  final int bookingId;
  final String? doctorId;
  final String chatPartnerName;

  /// 0 = User (patient)
  /// 1 = Doctor
  final int currentUserSenderType;

  const ChatScreen({
    super.key,
    required this.bookingId,
    required this.chatPartnerName,
    required this.currentUserSenderType,
    this.doctorId,
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

    context.read<ChatCubit>().initChat(
          widget.bookingId,
        );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  void _sendMessage() {
    final content = _inputController.text.trim();

    if (content.isEmpty) return;

    _inputController.clear();

    final cubit = context.read<ChatCubit>();

    cubit.sendMessage(
      widget.bookingId,
      content,
      widget.currentUserSenderType,
    );

    cubit.markAsRead(
      widget.bookingId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: ChatAppBar(
        chatPartnerName: widget.chatPartnerName,
      ),
      body: Column(
        children: [
          /// Connection Banner
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (previous, current) => current is ChatLoadedState,
            builder: (context, state) {
              if (state is ChatLoadedState &&
                  state.connectionState != ChatConnectionState.connected) {
                return ConnectionBanner(
                  state: state.connectionState,
                );
              }

              return const SizedBox.shrink();
            },
          ),

          /// Main Content
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is BookingStatusUpdatedState) {
                  _showBookingStatusSnackBar(
                    context,
                    state,
                  );
                }

                if (state is ChatLoadedState) {
                  _scrollToBottom();

                  context.read<ChatCubit>().markAsRead(
                        widget.bookingId,
                      );

                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage!,
                        ),
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
                  return const LoadingView();
                }

                if (state is ChatErrorState) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () {
                      context.read<ChatCubit>().initChat(
                            widget.bookingId,
                          );
                    },
                  );
                }

                if (state is ChatLoadedState) {
                  return MessageList(
                    state: state,
                    currentUserSenderType: widget.currentUserSenderType,
                    scrollController: _scrollController,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          /// Input
          ChatInputBar(
            controller: _inputController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _showBookingStatusSnackBar(
    BuildContext context,
    BookingStatusUpdatedState state,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking ${state.status.status}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  if (state.status.message.isNotEmpty)
                    Text(
                      state.status.message,
                      style: const TextStyle(
                        color: Colors.white,
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
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
