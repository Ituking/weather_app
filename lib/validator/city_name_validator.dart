import 'package:weather_app/validator/validator.dart';

// 都市名のバリデーションを行うクラス
//
// 都市名が空でないこと、または英字とスペースのみで構成されていることを検証します。
class CityNameValidator implements Validator<String> {
  // 都市名の形式をチェックするための正規表現
  // 英字とスペースのみを許可します。
  static final RegExp _cityNameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  // バリデーションエラーメッセージを保持するフィールド
  String _message = '';

  // 都市名を検証するメソッド
  //
  // [value] - 検証対象の都市名
  //
  // 戻り値は、バリデーションが成功した場合は `true`、失敗した場合は `false` を返します。
  @override
  bool validate(String value) {
    if (value.isEmpty) {
      _message = '都市名を入力してください。';
      return false;
    } else if (!_cityNameRegExp.hasMatch(value)) {
      _message = '都市名は英字とスペースのみを使用してください。';
      return false;
    }
    _message = ''; // バリデーションが成功した場合、エラーメッセージを空に設定
    return true;
  }

  // バリデーションエラーメッセージを取得するメソッド
  //
  // 戻り値は、バリデーションに失敗した場合のエラーメッセージです。
  // バリデーションが成功した場合は空文字列が返されます。
  @override
  String getMessage() {
    return _message;
  }
}
