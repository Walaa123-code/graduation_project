import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import '../../../profile_user/ui/manager/notification_cubit.dart';
import '../../../profile_user/ui/widgets/custom/notifications_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(85);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: 85,
      backgroundColor: AppColors.grayShad1Color,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello!", style: AppStyles.bold25Black),
              // ── Notification bell with badge ──────────────────
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  final hasUnread = state is NotificationUpdatedState
                      ? state.hasUnread
                      : false;

                  return GestureDetector(
                    onTap: () {
                      context.read<NotificationCubit>().markAllAsRead();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<NotificationCubit>(),
                            child: const NotificationsScreen(),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.notifications_outlined,
                            size: 28, color: AppColors.blackColor),
                        if (hasUnread)
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          Text("How are you feeling Today?", style: AppStyles.medium17Gray),
        ],
      ),
    );
  }
}
