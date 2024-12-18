import 'package:dio/dio.dart';

import '../strings/dio_error_handler_strings.dart';
import 'api_error.dart';

// DioErrorHandlerクラスはDioExceptionを処理し、適切なApiErrorに変換します。
class DioErrorHandler {
  // DioExceptionを受け取り、対応するApiErrorを返すメソッド。
  ApiError handle(DioException error) {
    switch (error.type) {
      // 接続タイムアウトエラーの処理
      case DioExceptionType.connectionTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: DioErrorHandlerStrings.connectionTimeout,
        );

      // リクエスト送信タイムアウトエラーの処理
      case DioExceptionType.sendTimeout:
        return const ApiError(
            type: ApiErrorType.timeout,
            message: DioErrorHandlerStrings.sendTimeout);

      // レスポンス受信タイムアウトエラーの処理
      case DioExceptionType.receiveTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: DioErrorHandlerStrings.receiveTimeout,
        );

      // 不正リクエストなどのサーバーからのエラーレスポンスの処理
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return const ApiError(
              type: ApiErrorType.badRequest,
              message: DioErrorHandlerStrings.badRequest,
            );
          case 401:
            return const ApiError(
              type: ApiErrorType.unauthorized,
              message: DioErrorHandlerStrings.unauthorized,
            );
          case 404:
            return const ApiError(
              type: ApiErrorType.notFound,
              message: DioErrorHandlerStrings.notFound,
            );
          case 429:
            return const ApiError(
              type: ApiErrorType.tooManyRequests,
              message: DioErrorHandlerStrings.tooManyRequests,
            );
          case 500:
          case 502:
          case 503:
          case 504:
            return const ApiError(
              type: ApiErrorType.internalServerError,
              message: DioErrorHandlerStrings.internalServerError,
            );
          default:
            return const ApiError(
              type: ApiErrorType.unknown,
              message: DioErrorHandlerStrings.unknownError,
            );
        }

      // リクエストがキャンセルされた場合の処理
      case DioExceptionType.cancel:
        return const ApiError(
          type: ApiErrorType.cancel,
          message: DioErrorHandlerStrings.requestCancelled,
        );

      // その他の未知のエラータイプの処理
      case DioExceptionType.unknown:
      default:
        return const ApiError(
          type: ApiErrorType.unknown,
          message: DioErrorHandlerStrings.unknownError,
        );
    }
  }
}
