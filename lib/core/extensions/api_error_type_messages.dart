import '../network/api_error.dart';

/// [ApiErrorType] に対するUI表示メッセージ拡張
extension ApiErrorTypeMessages on ApiErrorType {
  String get displayMessage {
    switch (this) {
      case ApiErrorType.timeout:
        return '接続タイムアウトが発生しました。\nネットワークの状態を確認してください。';
      case ApiErrorType.cancel:
        return 'リクエストがキャンセルされました。';
      case ApiErrorType.badRequest:
        return 'リクエストが不正です。\n必須パラメータが欠如しているか、フォーマットが不正です。';
      case ApiErrorType.unauthorized:
        return '認証されていません。\nAPIトークンが提供されていないか、アクセス権がありません。';
      case ApiErrorType.notFound:
        return 'データが見つかりませんでした。\nリクエストパラメータに誤りがあります。';
      case ApiErrorType.tooManyRequests:
        return 'リクエストが多すぎます。\nしばらく待ってから再試行してください。';
      case ApiErrorType.internalServerError:
        return '内部サーバーエラーが発生しました。\nしばらくしてから再試行してください。';
      case ApiErrorType.unknown:
        return '不明なエラーが発生しました。\n後でもう一度お試しください。';
    }
  }
}
