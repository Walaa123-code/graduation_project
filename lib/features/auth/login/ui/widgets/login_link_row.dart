import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import '../pages/login_screen.dart';

/// Row بيقول "Already have an account? Login"
/// يتستخدم في Register و Doctor Register
class LoginLinkRow extends StatelessWidget {
  const LoginLinkRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 15, color: AppColors.gray500),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
