import 'package:dio/dio.dart';
import 'package:weather_app/core/network/api_error.dart';

// DioErrorHandlerクラスはDioExceptionを処理し、適切なApiErrorに変換します。
class DioErrorHandler {
  // DioExceptionを受け取り、対応するApiErrorを返すメソッド。
  ApiError handle(DioException error) {
    switch (error.type) {
      // 接続タイムアウトエラーの処理
      case DioExceptionType.connectionTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: '接続タイムアウトが発生しました。\nネットワークの状態を確認してください。',
        );

      // リクエスト送信タイムアウトエラーの処理
      case DioExceptionType.sendTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: 'リクエスト送信タイムアウトが発生しました。\nネットワークの状態を確認してください。',
        );

      // レスポンス受信タイムアウトエラーの処理
      case DioExceptionType.receiveTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: 'レスポンス受信タイムアウトが発生しました。\nネットワークの状態を確認してください。',
        );

      // 不正リクエストなどのサーバーからのエラーレスポンスの処理
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return const ApiError(
              type: ApiErrorType.badRequest,
              message: 'リクエストが不正です。\n必須パラメータが欠如しているか、フォーマットが不正です。',
            );
          case 401:
            return const ApiError(
              type: ApiErrorType.unauthorized,
              message: '認証されていません。\nAPIトークンが提供されていないか、アクセス権がありません。',
            );
          case 404:
            return const ApiError(
              type: ApiErrorType.notFound,
              message: 'データが見つかりませんでした。\nリクエストパラメータに誤りがあります。',
            );
          case 429:
            return const ApiError(
              type: ApiErrorType.tooManyRequests,
              message: 'リクエストが多すぎます。\nしばらく待ってから再試行してください。',
            );
          case 500:
          case 502:
          case 503:
          case 504:
            return const ApiError(
              type: ApiErrorType.internalServerError,
              message: '内部サーバーエラーが発生しました。\nしばらくしてから再試行してください。',
            );
          default:
            return const ApiError(
              type: ApiErrorType.unknown,
              message: '不明なエラーが発生しました。\n後でもう一度お試しください。',
            );
        }

      // リクエストがキャンセルされた場合の処理
      case DioExceptionType.cancel:
        return const ApiError(
          type: ApiErrorType.cancel,
          message: 'リクエストがキャンセルされました。',
        );

      // その他の未知のエラータイプの処理
      case DioExceptionType.unknown:
      default:
        return const ApiError(
          type: ApiErrorType.unknown,
          message: '不明なエラーが発生しました。\n後でもう一度お試しください。',
        );
    }
  }
}
