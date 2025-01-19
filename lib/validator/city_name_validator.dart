import '../core/strings/city_name_validator_strings.dart';
import 'validator.dart';

/// 都市名のバリデーションを行うクラス。
///
/// 英字とスペースのみで構成され、空でないことを検証します。
class CityNameValidator implements Validator<String> {
  static final RegExp _cityNameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  String _message = '';

  /// 入力された都市名[value]を検証します。
  ///
  /// - `true`: バリデーション成功
  /// - `false`: バリデーション失敗
  @override
  bool validate(String value) {
    if (value.isEmpty) {
      _message = CityNameValidatorStrings.cityNameEmpty;
      return false;
    } else if (!_cityNameRegExp.hasMatch(value)) {
      _message = CityNameValidatorStrings.cityNameInvalid;
      return false;
    }
    _message = '';
    return true;
  }

  /// バリデーションエラーメッセージを取得します。
  ///
  /// バリデーションに失敗した場合、その理由を示すメッセージを返します。
  /// 成功した場合は空文字列を返します。
  @override
  String getMessage() {
    return _message;
  }
}
