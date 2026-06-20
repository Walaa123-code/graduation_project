import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/core/utils/app_theme.dart';
import 'package:mindecho/features/chat/ui/manager/chat_cubit.dart';

class ChatAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String chatPartnerName;

  const ChatAppBar({
    super.key,
    required this.chatPartnerName,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.gray700,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.purpleBg,
            child: Text(
              chatPartnerName.isNotEmpty
                  ? chatPartnerName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(width: AppTheme.spacingSm),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  chatPartnerName,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontWeight:
                    FontWeight.w700,
                    fontSize: 16,
                  ),
                ),

                BlocBuilder<
                    ChatCubit,
                    ChatState>(
                  buildWhen:
                      (p, c) =>
                  c is ChatLoadedState,
                  builder:
                      (context, state) {
                    final label =
                    _connectionLabel(
                        state);

                    if (label == null) {
                      return const SizedBox
                          .shrink();
                    }

                    return Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                        _connectionColor(
                            state),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _connectionLabel(
      ChatState state) {
    if (state is! ChatLoadedState) {
      return null;
    }

    switch (state.connectionState) {
      case ChatConnectionState.connecting:
        return 'Connecting...';

      case ChatConnectionState.reconnecting:
        return 'Reconnecting...';

      case ChatConnectionState.disconnected:
        return 'Disconnected';

      case ChatConnectionState.error:
        return 'Connection Error';

      case ChatConnectionState.connected:
        return null;
    }
  }

  Color _connectionColor(
      ChatState state) {
    if (state is! ChatLoadedState) {
      return AppColors.gray400;
    }

    switch (state.connectionState) {
      case ChatConnectionState.connected:
        return Colors.green;

      case ChatConnectionState.reconnecting:
        return AppColors.accentOrange;

      case ChatConnectionState.disconnected:
      case ChatConnectionState.error:
        return Colors.red;

      case ChatConnectionState.connecting:
        return AppColors.gray400;
    }
  }
}