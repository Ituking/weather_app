class DioErrorHandlerStrings {
  static const connectionTimeout = '接続タイムアウトが発生しました。\nネットワークの状態を確認してください。';
  static const sendTimeout = 'リクエスト送信タイムアウトが発生しました。\nネットワークの状態を確認してください。';
  static const receiveTimeout = 'レスポンス受信タイムアウトが発生しました。\nネットワークの状態を確認してください。';
  static const badRequest = 'リクエストが不正です。\n必須パラメータが欠如しているか、フォーマットが不正です。';
  static const unauthorized = '認証されていません。\nAPIトークンが提供されていないか、アクセス権がありません。';
  static const notFound = 'データが見つかりませんでした。\nリクエストパラメータに誤りがあります。';
  static const tooManyRequests = 'リクエストが多すぎます。\nしばらく待ってから再試行してください。';
  static const internalServerError = '内部サーバーエラーが発生しました。\nしばらくしてから再試行してください。';
  static const unknownError = '不明なエラーが発生しました。\n後でもう一度お試しください。';
  static const requestCancelled = 'リクエストがキャンセルされました。';
}
