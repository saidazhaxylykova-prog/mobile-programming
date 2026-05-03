import 'package:flutter/material.dart';

class AppColors {
  static const pinkSoft = Color(0xFFFFD6E7);
  static const pinkPrimary = Color(0xFFFF8FB1);
  static const pinkDeep = Color(0xFFE85A8A);
  static const lavender = Color(0xFFD5C6F0);
  static const lavenderDeep = Color(0xFFB39DDB);
  static const purpleDeep = Color(0xFF6B4E9C);
  static const cream = Color(0xFFFFF5F9);
  static const bgLight = Color(0xFFFFF8FB);
  static const bgDark = Color(0xFF1B0E23);
  static const cardDark = Color(0xFF2A1A36);
  static const textDark = Color(0xFF3A2A4A);
  static const textLight = Color(0xFFF7E9F2);
  static const heart = Color(0xFFFF5277);

  static const gradientPink = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pinkPrimary, lavenderDeep],
  );

  static const gradientSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pinkSoft, lavender],
  );
}
