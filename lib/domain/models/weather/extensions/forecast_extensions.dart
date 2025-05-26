import '../forecast.dart';

/// [Forecast]クラスにローカライズ機能を追加する拡張。
extension ForecastLocalization on Forecast {
  /// 指定されたロケールに対応する都市名を返す。
  /// 対応する翻訳がない場合は、デフォルトの都市名を返す。
  String localizedCity(String locale) => cityTranslations[locale] ?? city;

  /// 指定されたロケールに対応する天気の説明を返す。
  /// 対応する翻訳がない場合は、デフォルトの説明を返す。
  String localizedDescription(String locale) =>
      descriptionTranslations[locale] ?? description;
}
