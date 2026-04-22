import 'package:flutter/material.dart';

/// CalmYou App Color Palette
/// Calming colors for mental wellness: teal, light blue, soft purple, white
class AppColors {
  // Primary Colors
  static const Color primary = purpleSoft; // New Primary
  static const Color primaryTeal = Color(0xFF4ECDC4); // Kept for Splash
  static const Color tealLight = Color(0xFF7FE3DB);
  static const Color tealBg = Color(0xFFE8F5F4);

  // Secondary Colors
  static const Color blueLightCalm = Color(0xFFA8D8EA);
  static const Color purpleSoft = Color(0xFF9B7EBD);
  static const Color purpleLight = Color(0xFFD4B5F0);
  static const Color purpleBg = Color(0xFFF3E8FF);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF7FAFC);
  static const Color gray100 = Color(0xFFEDF2F7);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E0);
  static const Color gray400 = Color(0xFFA0AEC0);
  static const Color gray500 = Color(0xFF718096);
  static const Color gray600 = Color(0xFF4A5568);
  static const Color gray700 = Color(0xFF2D3748);
  static const Color gray800 = Color(0xFF1A202C);

  // Accent Colors for Illustrations
  static const Color accentYellow = Color(0xFFFFD4A3);
  static const Color accentOrange = Color(0xFFFFB84D);

  // Gradient Colors
  static const List<Color> splashGradient = [
    blueLightCalm,
    tealLight,
    purpleLight,
  ];

  // Shadow Colors
  static Color shadowTeal = primaryTeal.withValues(alpha: 0.3);
  static Color shadowPurple = purpleSoft.withValues(alpha: 0.3);
  static Color shadowDefault = Colors.black.withValues(alpha: 0.08);
}
