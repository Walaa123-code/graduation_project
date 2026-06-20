import 'package:flutter/material.dart';

class AppColors {
  // === Primary & Brand Colors ===
  static const Color primary = purpleSoft; // New Primary
  static const Color primaryTeal = Color(0xFF4ECDC4); // Kept for Splash
  static const Color teal = Color(0xFF14B8A6); // Teal original
  static const Color tealLight = Color(0xFF7FE3DB);
  static const Color tealBg = Color(0xFFE8F5F4);
  static const Color tealBgOriginal = Color(0xFFF0FDFA);

  // === Purple & Lavender Colors ===
  static const Color purpleSoft = Color(0xFF9643B6);
  static const Color lavenderColor = Color(0xFF9643B6); // نفس قيمة purpleSoft
  static const Color purpleLight = Color(0xFFD4B5F0);
  static const Color purpleLightOriginal = Color(0xFFC4B5FD);
  static const Color purpleBg = Color(0xFFF3E8FF);
  static const Color purpleBgOriginal = Color(0xFFF5F3FF);
  static const Color purple = Color(0xff8E54E9);

  // === Blue Colors ===
  static const Color blueColor = Color(0xFF42A5F5);
  static const Color blue = Color(0xff4A6CF7);
  static const Color blueLightCalm = Color(0xFFA8D8EA);

  // === Other Base Colors ===
  static const Color mintColor = Color(0xffa6e6dc);
  static const Color red = Color(0xffda0d0d);
  static const Color whiteColor = Color(0xf0ffffff);
  static const Color darkWhitColor = Color(0xefefefef);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xff171717);

  // === Accent Colors ===
  static const Color accentOrange = Color(0xFFFFB84D);
  static const Color accentOrangeOriginal = Color(0xFFF97316);
  static const Color accentYellow = Color(0xFFFFD4A3);

  // === Gray Scale (Combined & Ordered) ===
  static const Color gray50 = Color(0xFFF7FAFC);
  static const Color gray50Original = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFEDF2F7);
  static const Color gray100Original = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray200Original = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFCBD5E0);
  static const Color gray300Original = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFFA0AEC0);
  static const Color gray400Original = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF718096);
  static const Color gray500Original = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4A5568);
  static const Color gray600Original = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF2D3748);
  static const Color gray700Original = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1A202C);
  static const Color gray800Original = Color(0xFF1F2937);

  static const Color grayColor = Color(0xffA0A0A0);
  static const Color mediumGrayColor = Color(0xff515151);
  static const Color darkGrayColor = Color(0xff333333);

  // === Material Dynamic Grays (No Const) ===
  static final Color grayShadColor = Colors.grey.shade50;
  static final Color grayShad1Color = Colors.grey.shade100;

  // === Gradients ===
  static const LinearGradient gradient = LinearGradient(
    colors: [lavenderColor, blueColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<Color> splashGradient = [
    blueLightCalm,
    tealLight,
    purpleLight,
  ];

  // === Shadow Colors (Dynamic - No Const) ===
  static final Color shadowTeal = primaryTeal.withValues(alpha: 0.3);
  static const Color shadowTealOriginal = Color(0x3314B8A6);
  static final Color shadowPurple = purpleSoft.withValues(alpha: 0.3);
  static const Color shadowPurpleOriginal = Color(0x33A78BFA);
  static final Color shadowDefault = Colors.black.withValues(alpha: 0.08);
  static const Color shadowDefaultOriginal = Color(0x1A000000);
}
