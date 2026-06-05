import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/chat/data/services/chat_signalr_service.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';
import 'package:mindecho/features/chat/ui/widgets/chat_message_bubble.dart';
import 'package:mindecho/features/chat/ui/widgets/chat_input_field.dart';

class ChatScreen extends StatefulWidget {
  final int bookingId;
  final String doctorId;

  const ChatScreen({
    super.key,
    required this.bookingId,
    required this.doctorId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  late final ChatCubit _chatCubit;

  @override
  void initState() {
    super.initState();
    _chatCubit = ChatCubit(signalRService: ChatSignalRService());
    _chatCubit.initChat(widget.bookingId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _chatCubit.close();
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
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    _chatCubit.sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatCubit,
      child: Scaffold(
        backgroundColor: AppColors.gray50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: AppColors.lavenderColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.lavenderColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_outline,
                    color: AppColors.lavenderColor, size: 22),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Doctor Chat", style: AppStyles.bold18Black),
                  Text(
                    "Booking #${widget.bookingId}",
                    style: AppStyles.medium15Gray.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatMessagesLoadedState ||
                state is ChatNewMessageState) {
              _scrollToBottom();
            }
            if (state is BookingStatusChangedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    '${state.statusData.doctorName}: ${state.statusData.message}'),
                backgroundColor: AppColors.lavenderColor,
              ));
            }
            if (state is ChatErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (context, state) {
            if (state is ChatConnectingState) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.lavenderColor),
                    SizedBox(height: 12),
                    Text("Connecting to chat..."),
                  ],
                ),
              );
            }

            if (state is ChatErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(state.message, style: AppStyles.medium16DarkGray),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () =>
                          _chatCubit.initChat(widget.bookingId),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lavenderColor),
                      child: Text("Retry", style: AppStyles.bold20Whit),
                    ),
                  ],
                ),
              );
            }

            final messages = _chatCubit.messages;

            return Column(
              children: [
                Expanded(
                  child: messages.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return ChatMessageBubble(
                              message: messages[index],
                            );
                          },
                        ),
                ),
                ChatInputField(
                  controller: _textController,
                  onSend: _sendMessage,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lavenderColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_outline,
                size: 50, color: AppColors.lavenderColor),
          ),
          const SizedBox(height: 16),
          Text("No messages yet", style: AppStyles.bold20Black),
          const SizedBox(height: 8),
          Text("Start the conversation!", style: AppStyles.medium16Gray),
        ],
      ),
    );
  }
}
