import 'package:dio/dio.dart';

import '../strings/dio_error_handler_strings.dart';
import 'api_error.dart';

/// [DioErrorHandler] クラスは、[DioException] を処理し、適切な [ApiError] に変換します。
class DioErrorHandler {
  /// [DioException] を受け取り、対応する [ApiError] を返すメソッド。
  ///
  /// [error] : 処理する [DioException]。
  /// 戻り値 : 対応する [ApiError]。
  ApiError handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: DioErrorHandlerStrings.connectionTimeout,
        );
      case DioExceptionType.sendTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: DioErrorHandlerStrings.sendTimeout,
        );
      case DioExceptionType.receiveTimeout:
        return const ApiError(
          type: ApiErrorType.timeout,
          message: DioErrorHandlerStrings.receiveTimeout,
        );
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
      case DioExceptionType.cancel:
        return const ApiError(
          type: ApiErrorType.cancel,
          message: DioErrorHandlerStrings.requestCancelled,
        );
      case DioExceptionType.unknown:
      default:
        return const ApiError(
          type: ApiErrorType.unknown,
          message: DioErrorHandlerStrings.unknownError,
        );
    }
  }
}
