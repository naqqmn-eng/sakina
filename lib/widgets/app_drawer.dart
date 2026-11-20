import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';
import '../screens/info_screens.dart';
import '../screens/settings_screen.dart';
import '../services/storage_service.dart';

class AppDrawer extends StatelessWidget {
  final Future<void> Function()? onOpenSettings;
  const AppDrawer({super.key, this.onOpenSettings});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.navy,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.accent.withOpacity(0.15),
                    border: Border.all(color: AppTheme.accent.withOpacity(0.4)),
                  ),
                  child: const Icon(Icons.nightlight_round, color: AppTheme.accent, size: 29),
                ),
                const SizedBox(height: 12),
                const Text(
                  'سَكِينة',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.text),
                ),
                Text(
                  'رفيق الذكر والطمأنينة',
                  style: TextStyle(color: AppTheme.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppTheme.accent),
            title: const Text('الرئيسية'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppTheme.accent),
            title: const Text('الإعدادات'),
            onTap: () async {
              Navigator.pop(context);
              if (onOpenSettings != null) {
                await onOpenSettings!();
              } else {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(storage: StorageService()),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline, color: AppTheme.accent),
            title: const Text('المساعدة والدعم'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: AppTheme.accent),
            title: const Text('عن التطبيق'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share, color: AppTheme.accent),
            title: const Text('مشاركة التطبيق'),
            onTap: () {
              Navigator.pop(context);
              Share.share(
                'سَكِينة - رفيق الذكر والطمأنينة\nحمّل التطبيق وابدأ الذكر معنا.\n${AppConstants.telegramLink}',
              );
            },
          ),
          const Divider(color: AppTheme.outline),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${AppConstants.developerName}  •  v${AppConstants.appVersion}',
              style: TextStyle(color: AppTheme.muted, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
