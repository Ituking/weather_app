import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/providers/locale_notifier_provider.dart';

/// 言語選択肢用のリストタイルウィジェット。
/// 選択された言語にチェックマークを表示し、タップで切り替えを行います。
class LanguageOptionTile extends ConsumerWidget {
  final String languageCode;
  final String label;
  final String flag;

  const LanguageOptionTile({
    super.key,
    required this.languageCode,
    required this.label,
    required this.flag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeNotifierProvider);
    final isSelected = selectedLocale?.languageCode == languageCode;

    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 28)),
      title: Text(label),
      trailing:
          isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        ref.read(localeNotifierProvider.notifier).setLocale(languageCode);
      },
    );
  }
}
