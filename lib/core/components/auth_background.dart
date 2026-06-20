import 'package:flutter/material.dart';

/// الخلفية المشتركة لكل شاشات الـ Auth (gradient + decorative circles)
class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B3FA0), Color(0xFF9643B6), Color(0xFFD4B5F0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Circle 1
        Positioned(
          top: -60,
          right: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        // Circle 2
        Positioned(
          top: 80,
          left: -40,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),
      ],
    );
  }
}
