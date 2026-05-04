import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/message_item.dart';

class MessageTile extends StatelessWidget {
  final MessageItem message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(child: _buildContent(context)),
                _buildTrailing(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: message.avatarColor.withValues(alpha: 0.15),
          child: Text(
            message.initials,
            style: TextStyle(
              color: message.avatarColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        if (message.isOnline)
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF48BB78),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.patientName,
          style: TextStyle(
            fontSize: 15,
            fontWeight:
                message.unreadCount > 0 ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.gray800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          message.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color:
                message.unreadCount > 0 ? AppColors.gray700 : AppColors.gray400,
            fontWeight:
                message.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message.time,
          style: TextStyle(
            fontSize: 11,
            color:
                message.unreadCount > 0 ? AppColors.primary : AppColors.gray400,
            fontWeight:
                message.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 6),
        if (message.unreadCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Text(
              message.unreadCount.toString(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          const SizedBox(height: 18),
      ],
    );
  }
}
