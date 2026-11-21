import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  final int count;
  final int target;
  final double size;
  final Widget child;

  const ProgressRing({
    super.key,
    required this.count,
    required this.target,
    required this.child,
    this.size = 260,
  });

  @override
  Widget build(BuildContext context) {
    final progress = target <= 0 ? 0.0 : (count / target).clamp(0.0, 1.0);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // هالة نبض القلب خلف الدائرة - صارت زيتية هادية تلقائياً
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.accent.withOpacity(0.18),
                  AppTheme.accent.withOpacity(0.0),
                ],
              ),
            ),
          ),
          // الحلقة - صارت زيتية
          SizedBox(
            width: size - 20,
            height: size - 20,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: AppTheme.outline.withOpacity(0.6),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accent),
              strokeCap: StrokeCap.round,
            ),
          ),
          // الدائرة الداخلية - التعديل هنا: من زيتي فاقع إلى أسود
          Container(
            width: size - 60,
            height: size - 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.navy,
              border: Border.all(color: AppTheme.outline, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
          // نقطة صغيرة فوق - زيتية
          Positioned(
            top: 7,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: AppTheme.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.7),
                    blurRadius: 10,
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