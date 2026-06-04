import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/theme/app_theme.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';

/// Renders a single chat message bubble.
///
/// [isOutgoing] is determined by the caller (ChatScreen) by comparing
/// [message.messageSenderType] to the current user's role
/// (0 = User, 1 = Doctor).
class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isOutgoing;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isOutgoing,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: AppTheme.spacingXs,
          left: isOutgoing ? 64 : 0,
          right: isOutgoing ? 0 : 64,
        ),
        child: Column(
          crossAxisAlignment: isOutgoing
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            _buildBubble(context),
            const SizedBox(height: 2),
            _buildTimestamp(),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: isOutgoing ? AppColors.primary : AppColors.gray100,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppTheme.radiusLg),
          topRight: const Radius.circular(AppTheme.radiusLg),
          bottomLeft: isOutgoing
              ? const Radius.circular(AppTheme.radiusLg)
              : const Radius.circular(4),
          bottomRight: isOutgoing
              ? const Radius.circular(4)
              : const Radius.circular(AppTheme.radiusLg),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Text(
        message.content,
        style: TextStyle(
          fontSize: 15,
          color: isOutgoing ? AppColors.white : AppColors.gray700,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildTimestamp() {
    final hour = message.sentAt.hour.toString().padLeft(2, '0');
    final minute = message.sentAt.minute.toString().padLeft(2, '0');
    return Text(
      '$hour:$minute',
      style: const TextStyle(
        fontSize: 11,
        color: AppColors.gray400,
      ),
    );
  }
}
