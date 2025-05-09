import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locale_repository.dart';

class LocaleNotifier extends Notifier<Locale?> {
  late final LocaleRepository _repository;

  @override
  Locale? build() {
    _repository = LocaleRepository();
    _loadSavedLocale();
    return null; // デフォルトはシステム設定に従う
  }

  void _loadSavedLocale() async {
    final code = await _repository.loadLocale();
    if (code != null) {
      state = Locale(code);
    }
  }

  void setLocale(String languageCode) {
    final newLocale = Locale(languageCode);
    state = newLocale;
    _repository.saveLocale(languageCode);
  }
}
