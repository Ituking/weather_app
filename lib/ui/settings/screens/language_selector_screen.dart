import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/language_option_tile.dart';

/// 言語選択画面。
/// ユーザーがアプリの表示言語を選択できる画面を提供します。
class LanguageSelectorScreen extends ConsumerWidget {
  const LanguageSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select language')),
      body: ListView(
        children: const [
          // 言語選択肢のリスト
          LanguageOptionTile(languageCode: 'en', label: 'English'),
          LanguageOptionTile(languageCode: 'ja', label: '日本語'),
          LanguageOptionTile(languageCode: 'vi', label: 'Tiếng Việt'),
          LanguageOptionTile(languageCode: 'es', label: 'Español'),
          LanguageOptionTile(languageCode: 'fr', label: 'Français'),
          LanguageOptionTile(languageCode: 'zh', label: '中文'),
          LanguageOptionTile(languageCode: 'ar', label: 'العربية'),
          LanguageOptionTile(languageCode: 'de', label: 'Deutsch'),
          LanguageOptionTile(languageCode: 'ru', label: 'Русский'),
          LanguageOptionTile(languageCode: 'pt', label: 'Português'),
        ],
      ),
    );
  }
}
