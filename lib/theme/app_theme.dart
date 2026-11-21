import 'package:flutter/material.dart';

// سَكِينة v1.5.0 - الثيم الموحد النهائي
// استخدم هذه الاسماء فقط في كل المشروع
// navy - navyLight - accent - accentLight - muted - text - surface - card - outline

class AppTheme {
  // أسود - الخلفية والشريط العلوي
  static const Color navy = Color(0xFF000000);
  // زيتي جميل للزر الكبير - لا باهت ولا طيني
  static const Color navyLight = Color(0xFF6B7E2E);
  // زيتي أغمق - لأزرار اختيار الذكر والهدف الغير مختارة
  static const Color navyLighter = Color(0xFF3A451A);
  // زيتي فاتح - حدود الزر والزر المختار
  static const Color accent = Color(0xFFA8BC4A);
  // زيتي فاتح جداً - للنصوص الصغيرة المميزة
  static const Color accentLight = Color(0xFFD3DE8F);
  // أسود - خلفية الشاشة
  static const Color background = Color(0xFF000000);
  // أسود رمادي خفيف - للبطاقات على الأسود
  static const Color surface = Color(0xFF111111);
  static const Color card = Color(0xFF111111);
  // رمادي فاتح - للنصوص الباهتة
  static const Color muted = Color(0xFFB0B0B0);
  static const Color text = Colors.white;
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color primary = Color(0xFF6B7E2E);
  static const Color outline = Color(0xFF3A451A);
  static const Color raised = Color(0xFF3A451A);
  static const Color border = Color(0xFF3A451A);

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: navy,
    primaryColor: navyLight,
    colorScheme: const ColorScheme.dark(
      primary: accent,
      secondary: accentLight,
      surface: navyLight,
      background: navy,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: navy,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: navyLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: navyLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    useMaterial3: true,
  );

  static ThemeData get theme => darkTheme;
}