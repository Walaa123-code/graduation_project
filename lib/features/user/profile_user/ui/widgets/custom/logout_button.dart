import 'package:flutter/material.dart';
import 'package:mindecho/core/cashe/cashe_helper.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/auth/login/ui/pages/login_screen.dart';
import 'package:mindecho/core/utils/app_colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C)),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 15, color: Color(0xFF718096)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Color(0xFF718096), fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // close dialog
              await CasheHelper.deleteToken(); // clear token
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => const LoginScreen()),
                  (_) => false, // remove all routes
                );
              }
            },
            child: const Text(
              'Logout',
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _confirmLogout(context),
        icon: const Icon(Icons.logout_rounded, color: AppColors.red),
        label: Text('Logout', style: AppStyles.medium16Red),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.red, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
