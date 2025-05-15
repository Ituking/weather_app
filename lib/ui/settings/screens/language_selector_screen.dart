import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/locale_metadata.dart';
import '../../../core/i18n/providers/locale_notifier_provider.dart';
import '../../core/widgets/app_header.dart';
import '../widgets/language_option_tile.dart';

/// 言語選択画面。
/// ユーザーがアプリの表示言語を選択できる画面を提供します。
class LanguageSelectorScreen extends ConsumerWidget {
  const LanguageSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selected = ref.watch(localeNotifierProvider);
    final localeController = ref.read(localeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppHeader(
        title: l10n.languageSelectionTitle,
        showBackButton: false,
      ),
      body: ListView.builder(
        itemCount: supportedLocalesMetadata.length,
        itemBuilder: (context, index) {
          final meta = supportedLocalesMetadata[index];
          return LanguageOptionTile(
            languageCode: meta.languageCode,
            label: meta.label,
            flag: meta.flag,
            isSelected: selected?.languageCode == meta.languageCode,
            onTap: () => localeController.setLocale(meta.languageCode),
          );
        },
      ),
    );
  }
}
