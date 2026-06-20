import 'package:flutter/material.dart';

import 'package:mindecho/features/chat/ui/widgets/chat_bubble.dart';
import 'package:mindecho/features/chat/ui/widgets/seen_indicator.dart';

import '../manager/chat_cubit.dart';

class MessageList extends StatelessWidget {
  final ChatLoadedState state;
  final int currentUserSenderType;
  final ScrollController scrollController;

  const MessageList({
    super.key,
    required this.state,
    required this.currentUserSenderType,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (state.messages.isEmpty) {
      return const Center(
        child: Text('No messages yet'),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount:
      state.messages.length + (state.seenByOther ? 1 : 0),
      itemBuilder: (context, index) {
        if (state.seenByOther &&
            index == state.messages.length) {
          return const SeenIndicator();
        }

        final message = state.messages[index];

        final isOutgoing =
            message.messageSenderType ==
                currentUserSenderType;

        return ChatBubble(
          message: message,
          isOutgoing: isOutgoing,
        );
      },
    );
  }
}