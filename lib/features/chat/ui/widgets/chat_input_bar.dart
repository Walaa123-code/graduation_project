import 'package:flutter/material.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppTheme.spacingMd,
        right: AppTheme.spacingMd,
        top: AppTheme.spacingSm,
        bottom: AppTheme.spacingSm,
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
                  borderRadius:
                  BorderRadius.circular(AppTheme.radiusFull),
                  border: Border.all(
                    color: AppColors.gray200,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization:
                  TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Type a message…',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingSm),
            GestureDetector(
              onTap: onSend,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}