import 'package:flutter/material.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageEntity message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // نحدد لو الرسالة من الـ current user
    final currentUserId =
        SharedPreferencesUtils.getData(key: 'userId') as String?;
    final isMe = message.senderId == currentUserId ||
        message.messageSenderType == 0;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // sender label للـ doctor
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 4),
                child: Text(
                  "Doctor",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.lavenderColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.lavenderColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.content ?? '',
                style: TextStyle(
                  color: isMe ? Colors.white : AppColors.darkGrayColor,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),

            // الوقت
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _formatTime(message.sentAt),
                style: const TextStyle(
                    fontSize: 11, color: AppColors.grayColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    try {
      final d = dateTime.toLocal();
      final h = d.hour.toString().padLeft(2, '0');
      final m = d.minute.toString().padLeft(2, '0');
      return "$h:$m";
    } catch (_) {
      return '';
    }
  }
}
