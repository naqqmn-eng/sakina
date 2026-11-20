import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SakinaApp());
}

class SakinaApp extends StatelessWidget {
  const SakinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سَكِينة',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
