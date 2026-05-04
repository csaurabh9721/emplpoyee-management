import 'package:flutter/material.dart';

class AppColors {
  // 🔥 Primary Brand Colors (from splash)
  static const Color primary = Color(0xFF1E6ED8);     // main blue
  static const Color primaryDark = Color(0xFF0A2A6B); // deep blue
  static const Color secondary = Color(0xFF00A8A8);   // teal
  static const Color accent = Color(0xFF2ECC71);      // green

  // Backgrounds
  static const Color background = Color(0xFFF4F8FB);
  static const Color white = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF0A2A6B);
  static const Color textSecondary = Color(0xFF6B7A90);

  // Borders
  static const Color divider = Color(0xFFE3EAF2);
  static const Color inputBorder = Color(0xFFD0D7E2);

  // Components
  static const Color iconColor = Color(0xFF3A4A5A);
  static const Color disabled = Color(0xFFB0BEC5);
  static const Color error = Color(0xFFB00020);

  // UI
  static const Color dialogBackground = white;
  static const Color snackbarBackground = Colors.black87;

  // Optional gradient (VERY IMPORTANT)
  static const LinearGradient splashGradient = LinearGradient(
    colors: [
      Color(0xFF1E6ED8), // blue
      Color(0xFF00A8A8), // teal
      Color(0xFF2ECC71), // green
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
