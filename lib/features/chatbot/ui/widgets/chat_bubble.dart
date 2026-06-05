import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';

class ChatBubble extends StatelessWidget {
  final String content;
  final bool isUser;
  final String? time;

  const ChatBubble({
    super.key,
    required this.content,
    required this.isUser,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // أيقونة الـ bot
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.lavenderColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.smart_toy_outlined,
                          size: 14, color: AppColors.lavenderColor),
                    ),
                    const SizedBox(width: 6),
                   const Text("MindEcho",
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.lavenderColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),

            // الـ bubble
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? AppColors.lavenderColor : AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                content,
                style: TextStyle(
                  color: isUser ? Colors.white : AppColors.darkGrayColor,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),

            // الوقت
            if (time != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _formatTime(time!),
                  style: AppStyles.medium15Gray.copyWith(fontSize: 11),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String dateStr) {
    try {
      final d = DateTime.parse(dateStr);
      final h = d.hour.toString().padLeft(2, '0');
      final m = d.minute.toString().padLeft(2, '0');
      return "$h:$m";
    } catch (_) {
      return '';
    }
  }
}
