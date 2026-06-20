import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/ui/manager/chatbot_cubit.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/ui/widgets/chat_bubble.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/ui/widgets/chat_input_bar.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/ui/widgets/chat_typing_indicator.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/ui/widgets/chatbot_app_bar.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/ui/widgets/chatbot_welcome.dart';

import '../manager/chatbot_cubit.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final ChatBotCubit _cubit = getIt<ChatBotCubit>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit.getHistory();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
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
    _cubit.sendMessage(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.gray50,
        appBar: const ChatBotAppBar(),
        body: Column(
          children: [
            Expanded(child: _ChatBody(
              cubit: _cubit,
              scrollController: _scrollController,
              onRetry: _cubit.getHistory,
            )),
            ChatInputBar(
              controller: _textController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Chat Body ---
class _ChatBody extends StatelessWidget {
  final ChatBotCubit cubit;
  final ScrollController scrollController;
  final VoidCallback onRetry;

  const _ChatBody({
    required this.cubit,
    required this.scrollController,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBotCubit, ChatBotState>(
      listener: (context, state) {
        if (state is SendMessageSuccessState ||
            state is ChatHistorySuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
        if (state is SendMessageErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(friendlyErrorMessage(state.failures.errors.toString())),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ));
        }
      },
      builder: (context, state) {
        if (state is ChatHistoryLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.lavenderColor),
          );
        }

        if (state is ChatHistoryErrorState) {
          return AppErrorWidget(
            message: state.failures.errors.toString(),
            onRetry: onRetry,
            title: "Couldn't load chat",
            icon: Icons.chat_bubble_outline,
          );
        }

        final msgs = cubit.messages;
        if (msgs.isEmpty) return const ChatBotWelcome();

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: msgs.length + (state is SendMessageLoadingState ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == msgs.length && state is SendMessageLoadingState) {
              return const ChatTypingIndicator();
            }
            final msg = msgs[index];
            return ChatBubble(
              content: msg.content ?? '',
              isUser: msg.sender == 'User',
              time: msg.createdAt,
            );
          },
        );
      },
    );
  }
}

