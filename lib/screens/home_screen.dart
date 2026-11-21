import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import '../constants/app_constants.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/dhikr_selector.dart';
import '../widgets/progress_ring.dart';
import 'settings_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final StorageService _storage = StorageService();
  int _count = 0;
  int _total = 0;
  String _dhikr = AppConstants.dhikrs[0];
  int _target = 33;
  bool _hapticsEnabled = true;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _load();
  }

  Future<void> _load() async {
    final count = await _storage.getCount();
    final dhikr = await _storage.getDhikr();
    final target = await _storage.getTarget();
    final haptics = await _storage.getHaptics();
    final total = await _storage.getTotal();
    if (!mounted) return;
    setState(() {
      _count = count;
      _dhikr = dhikr;
      _target = target;
      _hapticsEnabled = haptics;
      _total = total;
    });
  }

  Future<void> _increment() async {
    if (_count >= _target) return; // العداد يوقف عند الهدف
    final newCount = _count + 1;
    final newTotal = _total + 1;
    setState(() {
      _count = newCount;
      _total = newTotal;
    });
    await _storage.saveCount(newCount);
    await _storage.saveTotal(newTotal);
    if (_hapticsEnabled) {
      HapticFeedback.lightImpact();
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 15);
      }
    }
    if (newCount == _target) {
      HapticFeedback.heavyImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ما شاء الله، وصلت لهدفك 🤍')),
        );
      }
    }
  }

  Future<void> _reset() async {
    setState(() => _count = 0);
    await _storage.saveCount(0);
  }

  Future<void> _changeDhikr(String dhikr) async {
    setState(() {
      _dhikr = dhikr;
      _count = 0;
    });
    await _storage.saveDhikr(dhikr);
    await _storage.saveCount(0);
  }

  Future<void> _changeTarget(int target) async {
    setState(() {
      _target = target;
      if (_count > target) _count = target;
    });
    await _storage.saveTarget(target);
    await _storage.saveCount(_count);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      drawer: AppDrawer(
        onOpenSettings: () async {
          final changed = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => SettingsScreen(storage: _storage)),
          );
          if (changed == true) _load();
        },
      ),
      appBar: AppBar(
        title: const Text('سَكِينة'),
        backgroundColor: AppTheme.navy,
        actions: [
          // التعديل 1: كلمة تصفير جنب زر التصفير
          TextButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text(
              'تصفير',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.text,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            DhikrSelector(
              selected: _dhikr,
              dhikrs: AppConstants.dhikrs,
              onChanged: _changeDhikr,
            ),
            const SizedBox(height: 22),
            // الدائرة + نبضة القلب
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.02),
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: _increment,
                child: ProgressRing(
                  count: _count,
                  target: _target,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'وِرْدُكَ الْيَوْم',
                        style: TextStyle(
                          color: AppTheme.accentLight,
                          fontSize: 11,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$_count',
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.text,
                        ),
                      ),
                      Text(
                        'من $_target',
                        style: TextStyle(color: AppTheme.muted, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'الذكر المختار: $_dhikr',
              style: const TextStyle(
                color: AppTheme.accent,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 22),
            // التعديل 2: الزر الكبير بدون أي أيقونة - نص فقط
            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: _increment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.navyLight,
                  foregroundColor: AppTheme.text,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: AppTheme.accent),
                  ),
                ),
                child: Text(
                  _dhikr,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // اختيار الهدف
            Row(
              children: [
                const Icon(Icons.flag, color: AppTheme.accent, size: 18),
                const SizedBox(width: 6),
                Text('هدفك: ', style: TextStyle(color: AppTheme.muted)),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: AppConstants.targets.map((t) {
                        final selected = t == _target;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text('$t'),
                            selected: selected,
                            onSelected: (_) => _changeTarget(t),
                            selectedColor: AppTheme.accent,
                            backgroundColor: AppTheme.navyLight,
                            labelStyle: TextStyle(
                              color: selected ? AppTheme.navy : AppTheme.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'إجمالي أذكارك: $_total',
              style: TextStyle(color: AppTheme.muted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}