import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DhikrSelector extends StatelessWidget {
  final String selected;
  final List<String> dhikrs;
  final ValueChanged<String> onChanged;

  const DhikrSelector({
    super.key,
    required this.selected,
    required this.dhikrs,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              // التعديل 1: شلنا أيقونة النجمة وحطينا أيقونة كتاب - أنظف وأبعد عن شكل الذكاء الاصطناعي
              child: const Icon(Icons.menu_book, color: AppTheme.accent, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الذِّكْر الحالي',
                    style: TextStyle(color: AppTheme.muted, fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selected,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.accent),
              onPressed: () async {
                final result = await showModalBottomSheet<String>(
                  context: context,
                  // التعديل 2: القائمة صارت سوداء بدل الزيتي الفاقع
                  backgroundColor: AppTheme.navy,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (ctx) => ListView(
                    shrinkWrap: true,
                    children: dhikrs.map((d) {
                      final isSelected = d == selected;
                      return ListTile(
                        title: Text(
                          d,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppTheme.accent : AppTheme.text,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: AppTheme.accent)
                            : null,
                        onTap: () => Navigator.pop(ctx, d),
                      );
                    }).toList(),
                  ),
                );
                if (result != null) onChanged(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}