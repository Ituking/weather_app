/// バリデーションを行う抽象クラス。
abstract class Validator<T> {
  /// 入力値 [value] を検証し、成功時に `true` を返す。
  bool validate(T value);

  /// 検証失敗時のエラーメッセージを取得する。
  String getMessage();
}
