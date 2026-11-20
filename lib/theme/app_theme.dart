import 'package:flutter/material.dart';

// سَكِينة v1.5.0 - الثيم الموحد النهائي
// استخدم هذه الاسماء فقط في كل المشروع
// navy - navyLight - accent - accentLight - muted - text - surface - card - outline

class AppTheme {
  static const Color navy = Color(0xFF0F1B2D);
  static const Color navyLight = Color(0xFF1A2E4A);
  static const Color navyLighter = Color(0xFF243A5A);
  static const Color accent = Color(0xFF7FB3D5);
  static const Color accentLight = Color(0xFFA8CBE8);
  static const Color background = Color(0xFF0F1B2D);
  static const Color surface = Color(0xFF1A2E4A);
  static const Color card = Color(0xFF1A2E4A);
  static const Color muted = Color(0xFF9AA9BC);
  static const Color text = Colors.white;
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9AA9BC);
  static const Color primary = Color(0xFF1A2E4A);
  static const Color outline = Color(0xFF2A4262);
  static const Color raised = Color(0xFF243A5A);
  static const Color border = Color(0xFF2A4262);

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
