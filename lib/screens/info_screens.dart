import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('عن التطبيق')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            color: AppTheme.card,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  // التعديل: شلنا القلب وحطينا هلال - أنظف وأبعد عن شكل الذكاء الاصطناعي
                  const Icon(Icons.nightlight_round, size: 56, color: AppTheme.accent),
                  const SizedBox(height: 12),
                  const Text(
                    'سَكِينة',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.text),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppConstants.appTagline,
                    style: TextStyle(color: AppTheme.muted, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'تطبيق  بسيط وهادئ، يساعدك على الذكر في أي وقت، مع اهتزاز لطيف وعداد يوقف عند هدفك.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.text),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: AppTheme.card,
            child: const ListTile(
              leading: Icon(Icons.info_outline, color: AppTheme.accent),
              title: Text('الإصدار', style: TextStyle(color: AppTheme.text)),
              subtitle: Text('1.2.0', style: TextStyle(color: AppTheme.muted)),
            ),
          ),
          Card(
            color: AppTheme.card,
            child: const ListTile(
              leading: Icon(Icons.person_outline, color: AppTheme.accent),
              title: Text('المطور', style: TextStyle(color: AppTheme.text)),
              subtitle: Text('ᯓN-A-Qᯓ | Nawaf ', style: TextStyle(color: AppTheme.muted)),
            ),
          ),
        ],
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  Future<void> openTelegram() async {
    final tgApp = Uri.parse(AppConstants.telegramAppLink);
    if (await canLaunchUrl(tgApp)) {
      await launchUrl(tgApp, mode: LaunchMode.externalApplication);
      return;
    }
    final tgWeb = Uri.parse(AppConstants.telegramLink);
    if (await canLaunchUrl(tgWeb)) {
      await launchUrl(tgWeb, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('المساعدة والدعم')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            color: AppTheme.card,
            child: const ListTile(
              leading: Icon(Icons.help_outline, color: AppTheme.accent),
              title: Text('كيف أستخدم التطبيق؟', style: TextStyle(color: AppTheme.text)),
              subtitle: Text('اختر الذكر من فوق، اضغط الدائرة أو الزر الكبير للتسبيح، واختار هدفك من زر الهدف.', style: TextStyle(color: AppTheme.muted)),
            ),
          ),
          Card(
            color: AppTheme.card,
            child: const ListTile(
              leading: Icon(Icons.vibration, color: AppTheme.accent),
              title: Text('الاهتزاز ما يشتغل؟', style: TextStyle(color: AppTheme.text)),
              subtitle: Text('روح للإعدادات وتأكد ان الاهتزاز شغال، .', style: TextStyle(color: AppTheme.muted)),
            ),
          ),
          Card(
            color: AppTheme.card,
            child: const ListTile(
              leading: Icon(Icons.flag, color: AppTheme.accent),
              title: Text('العداد يوقف عند الهدف؟', style: TextStyle(color: AppTheme.text)),
              subtitle: Text('ايوه، اذا وصلت للهدف بيوقف، صفّر العداد عشان تبدأ من جديد.', style: TextStyle(color: AppTheme.muted)),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: AppTheme.card,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.person_pin, size: 52, color: AppTheme.accent),
                  const SizedBox(height: 8),
                  const Text(
                    'ᯓN-A-Qᯓ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.text),
                  ),
                  Text('@U_S5S', style: TextStyle(color: AppTheme.muted)),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: openTelegram,
                    icon: const Icon(Icons.send),
                    label: const Text('التواصل عبر Telegram'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: '@U_S5S'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم نسخ اسم المستخدم')),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('نسخ اسم المستخدم'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}