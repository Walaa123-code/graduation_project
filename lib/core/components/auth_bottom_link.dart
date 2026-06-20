import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Divider + link row المشتركة في Auth screens
/// مثال: "Already have an account? Sign In"
class AuthBottomLink extends StatelessWidget {
  final String message;
  final String linkText;
  final VoidCallback onTap;

  const AuthBottomLink({
    super.key,
    required this.message,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with text
        Row(
          children: [
            const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                message,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
              ),
            ),
            const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
          ],
        ),
        const SizedBox(height: 22),
        // Outlined action button
        
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.purpleSoft,
              side: const BorderSide(color: AppColors.purpleSoft, width: 2),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                linkText,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

        ),
      ],
    );
  }
}
