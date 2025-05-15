class LocaleMetadata {
  final String languageCode;
  final String label;
  final String flag;

  const LocaleMetadata({
    required this.languageCode,
    required this.label,
    required this.flag,
  });
}

const List<LocaleMetadata> supportedLocalesMetadata = [
  LocaleMetadata(languageCode: 'en', label: 'English', flag: '🇺🇸'),
  LocaleMetadata(languageCode: 'ja', label: '日本語', flag: '🇯🇵'),
  LocaleMetadata(languageCode: 'vi', label: 'Tiếng Việt', flag: '🇻🇳'),
  LocaleMetadata(languageCode: 'es', label: 'Español', flag: '🇪🇸'),
  LocaleMetadata(languageCode: 'fr', label: 'Français', flag: '🇫🇷'),
  LocaleMetadata(languageCode: 'zh', label: '中文', flag: '🇨🇳'),
  LocaleMetadata(languageCode: 'ar', label: 'العربية', flag: '🇸🇦'),
  LocaleMetadata(languageCode: 'de', label: 'Deutsch', flag: '🇩🇪'),
  LocaleMetadata(languageCode: 'ru', label: 'Русский', flag: '🇷🇺'),
  LocaleMetadata(languageCode: 'pt', label: 'Português', flag: '🇧🇷'),
];
