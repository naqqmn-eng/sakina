import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  final StorageService storage;
  const SettingsScreen({super.key, required this.storage});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _haptics = true;
  int _target = 33;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final h = await widget.storage.getHaptics();
    final t = await widget.storage.getTarget();
    if (!mounted) return;
    setState(() {
      _haptics = h;
      _target = t;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // الاهتزاز - يشتغل على طول بدون اعادة تشغيل
          Card(
            color: AppTheme.card,
            child: SwitchListTile(
              value: _haptics,
              activeColor: AppTheme.accent,
              secondary: const Icon(Icons.vibration_rounded, color: AppTheme.accent),
              title: const Text(
                'الاهتزاز عند التسبيح',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              subtitle: const Text('اهتزاز خفيف مع كل ضغطة'),
              onChanged: (v) async {
                setState(() => _haptics = v);
                await widget.storage.saveHaptics(v);
                // يرجع true عشان الشاشة الرئيسية تحدث نفسها على طول
                Navigator.pop(context, true);
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'الهدف الافتراضي',
            style: TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: AppConstants.targets.map((t) {
              final selected = t == _target;
              return ChoiceChip(
                label: Text('$t'),
                selected: selected,
                onSelected: (_) async {
                  setState(() => _target = t);
                  await widget.storage.saveTarget(t);
                  if (mounted) Navigator.pop(context, true);
                },
                selectedColor: AppTheme.accent,
                backgroundColor: AppTheme.navyLight,
                labelStyle: TextStyle(
                  color: selected ? AppTheme.navy : AppTheme.text,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          Card(
            color: AppTheme.card,
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: AppTheme.accent),
              title: const Text('الإصدار'),
              subtitle: Text(AppConstants.appVersion),
            ),
          ),
        ],
      ),
    );
  }
}
