import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// 言語選択肢用のリストタイルウィジェット。
/// 選択された言語にチェックマークを表示し、タップで切り替えを行います。
class LanguageOptionTile extends StatelessWidget {
  final String languageCode;
  final String label;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionTile({
    super.key,
    required this.languageCode,
    required this.label,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 28)),
              Gap(16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: isSelected
                    ? const Icon(Icons.check_circle,
                        key: ValueKey('checked'), color: Colors.green)
                    : const Icon(Icons.radio_button_unchecked,
                        key: ValueKey('unchecked'), color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
