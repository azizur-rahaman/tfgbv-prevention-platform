import 'package:flutter/material.dart';

class AppColors {
  // Primary Backgrounds
  static const Color backgroundDark = Color(0xFF071426);
  static const Color backgroundLight = Color(0xFF0B1B2E);

  // Gradient Background
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      backgroundDark,
      backgroundLight,
    ],
  );

  // Accent Colors
  static const Color primaryAccent = Color(0xFF2F80ED); // Alternatively 0xFF1E6BD6

  // Status Colors
  static const Color success = Color(0xFF1ED760); // Alternatively 0xFF16C784
  static const Color warning = Color(0xFFF5A623);
  static const Color critical = Color(0xFFE02020); // Alternatively 0xFFFF2D2D

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
}
