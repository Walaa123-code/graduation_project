import 'package:flutter/material.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import '../manager/chat_cubit.dart';

class ConnectionBanner extends StatelessWidget {
  final ChatConnectionState state;

  const ConnectionBanner({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color bg;

    switch (state) {
      case ChatConnectionState.connecting:
        text = 'Connecting to chat…';
        bg = AppColors.gray300;
        break;

      case ChatConnectionState.reconnecting:
        text =
        'Connection lost — reconnecting…';
        bg = AppColors.accentOrange;
        break;

      case ChatConnectionState.disconnected:
        text = 'Disconnected';
        bg = AppColors.gray500;
        break;

      case ChatConnectionState.error:
        text = 'Connection error';
        bg = Colors.red;
        break;

      default:
        return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      color: bg,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingXs,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}