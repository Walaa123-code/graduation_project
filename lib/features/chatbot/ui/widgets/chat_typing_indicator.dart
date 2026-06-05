import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

class ChatTypingIndicator extends StatelessWidget {
  const ChatTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AnimatedDot(delay: 0),
            const SizedBox(width: 4),
            _AnimatedDot(delay: 150),
            const SizedBox(width: 4),
            _AnimatedDot(delay: 300),
          ],
        ),
      ),
    );
  }
}

class _AnimatedDot extends StatelessWidget {
  final int delay;
  const _AnimatedDot({required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + delay),
      builder: (_, v, __) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.lavenderColor.withValues(alpha: 0.4 + v * 0.6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
