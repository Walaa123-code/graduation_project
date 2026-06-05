import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import '../../../register/ui/pages/register_screen.dart';

/// Row بيقول "New here? Register now"
/// يتستخدم في Login screen
class RegisterLinkRow extends StatelessWidget {
  const RegisterLinkRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New here? ',
          style: TextStyle(fontSize: 15, color: AppColors.gray500),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const RegisterScreen()),
          ),
          child: const Text(
            'Register now',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.purpleSoft,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
